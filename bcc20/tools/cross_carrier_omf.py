"""Fail-closed partitioning of an already-transformed resident compiler OMF.

This module has no filesystem or importer dependencies. It validates and decodes
the complete function before splitting bytes; a native carrier need not begin at
an instruction boundary. The narrow v1 profile cannot move any tail relocation.
"""
from dataclasses import dataclass
import re

from iced_x86 import Code, Decoder, FlowControl, Mnemonic, OpKind


@dataclass(frozen=True)
class CodePartition:
    stem: str
    start: int
    end: int
    code_name: str
    code_attributes: int


@dataclass(frozen=True)
class _Segment:
    attributes: int
    size: int
    name: int
    class_name: int
    overlay: int


@dataclass(frozen=True)
class _Fixup:
    offset: int
    width: int
    location: int
    relative: bool
    frame: tuple
    target: tuple
    displacement: int


@dataclass
class _Object:
    records: list
    names: list
    segments: list
    groups: list
    externs: list
    code_index: int
    code: bytes
    fixups: list
    writers: dict


_DOS_STEM = re.compile(r'[A-Z_][A-Z0-9_]{0,7}\Z')
_SEGMENT_NAME = re.compile(r'[A-Za-z_$?@][A-Za-z0-9_$?@]{0,254}\Z')
_WIDTHS = {0: 1, 1: 2, 2: 2, 3: 4, 4: 1, 5: 2}


def _require(condition, message):
    if not condition:
        raise ValueError(message)


def _index(data, position):
    _require(position < len(data), 'Truncated OMF index')
    first = data[position]
    if first < 128:
        return first, position + 1
    _require(position + 1 < len(data), 'Truncated OMF index')
    value = ((first & 127) << 8) | data[position + 1]
    _require(value >= 128, 'Noncanonical OMF index')
    return value, position + 2


def _encode_index(value):
    _require(0 <= value <= 0x7fff, 'OMF index overflow')
    return bytes((value,)) if value < 128 else bytes((128 | (value >> 8), value & 255))


def _string(data, position):
    _require(position < len(data), 'Missing OMF string')
    end = position + 1 + data[position]
    _require(end <= len(data), 'Truncated OMF string')
    raw = data[position + 1:end]
    _require(all(32 <= c < 127 for c in raw), 'Non-ASCII/control OMF name')
    return raw.decode('ascii'), end


def _name_bytes(name):
    encoded = name.encode('ascii')
    return bytes((len(encoded),)) + encoded


def _record(kind, payload):
    _require(len(payload) < 65535, 'OMF record too large')
    raw = bytes((kind,)) + (len(payload) + 1).to_bytes(2, 'little') + payload
    return raw + bytes((-sum(raw) & 255,))


def _records(raw):
    _require(isinstance(raw, bytes), 'OMF must be bytes')
    result = []
    position = 0
    while position < len(raw):
        _require(position + 3 <= len(raw), 'Truncated OMF header')
        kind = raw[position]
        length = int.from_bytes(raw[position + 1:position + 3], 'little')
        end = position + 3 + length
        _require(length > 0 and end <= len(raw), 'Invalid/truncated OMF record length')
        _require(sum(raw[position:end]) & 255 == 0, 'Invalid OMF checksum')
        result.append((kind, raw[position + 3:end - 1]))
        position = end
    _require(bool(result) and result[0][0] == 0x80, 'Missing initial THEADR')
    _require(result[-1] == (0x8a, b'\0'), 'Expected MODEND without entry')
    _require(sum(t == 0x80 for t, _ in result) == 1, 'Multiple THEADR')
    _require(sum(t == 0x8a for t, _ in result) == 1, 'Multiple/early MODEND')
    return result


def _comment(payload):
    """Only the exact informational/debug forms emitted by the BC20 profile."""
    _require(len(payload) >= 2 and payload[0] == 0, 'Unsupported COMENT attributes')
    kind = payload[1]
    if kind == 0:
        _require(payload == b'\x00\x00\x1aTC86 Borland Turbo C++ 2.0',
                 'Unsupported compiler COMENT')
    elif kind == 0xea:
        _require(payload == b'\x00\xea\x01\x0a', 'Unsupported EA COMENT')
    elif kind == 0xe9:
        if payload != b'\x00\xe9':
            _require(len(payload) >= 7, 'Truncated dependency COMENT')
            name, end = _string(payload, 6)
            _require(bool(name) and end == len(payload), 'Invalid dependency COMENT')
    elif kind == 0xe8:
        _require(len(payload) >= 4 and payload[2] == 0, 'Unsupported E8 COMENT')
        name, end = _string(payload, 3)
        _require(bool(name) and end + 4 == len(payload), 'Invalid E8 COMENT')
    else:
        raise ValueError('Unsupported COMENT class')


def _parse(raw):
    records = _records(raw)
    names, segments, groups, externs = [''], [None], [None], [None]
    writers, pending = {}, []
    last = None
    data_started = False
    for record_number, (kind, payload) in enumerate(records):
        if kind not in (0xa0, 0x9c):
            last = None
        if kind == 0x80:
            name, end = _string(payload, 0)
            _require(bool(name) and end == len(payload), 'Invalid THEADR')
        elif kind == 0x88:
            _comment(payload)
        elif kind == 0x96:
            _require(not data_started, 'LNAMES after data')
            position = 0
            _require(bool(payload), 'Empty LNAMES')
            while position < len(payload):
                name, position = _string(payload, position)
                names.append(name)
            _require(len(names) <= 0x8000, 'Too many names')
        elif kind == 0x98:
            _require(not data_started and len(payload) >= 6, 'Invalid SEGDEF ordering/length')
            attributes = payload[0]
            _require(attributes & 3 == 0 and attributes >> 5 in (1, 2, 3, 4, 5),
                     'Unsupported SEGDEF attributes')
            size = int.from_bytes(payload[1:3], 'little')
            name, position = _index(payload, 3)
            class_name, position = _index(payload, position)
            overlay, position = _index(payload, position)
            _require(position == len(payload), 'Trailing SEGDEF fields')
            _require(all(0 < i < len(names) for i in (name, class_name, overlay)),
                     'Invalid SEGDEF name index')
            _require(_SEGMENT_NAME.fullmatch(names[name]) is not None,
                     'Invalid segment name')
            _require(names[class_name] in ('CODE', 'DATA', 'BSS') and names[overlay] == '',
                     'Unsupported segment class/overlay')
            permitted = (0x28,) if names[class_name] == 'CODE' else (0x28, 0x48, 0x68)
            _require(attributes in permitted, 'Unknown segment alignment/combine profile')
            segments.append(_Segment(attributes, size, name, class_name, overlay))
        elif kind == 0x9a:
            _require(not data_started, 'GRPDEF after data')
            name, position = _index(payload, 0)
            _require(0 < name < len(names) and _SEGMENT_NAME.fullmatch(names[name]),
                     'Invalid GRPDEF name')
            members = []
            while position < len(payload):
                _require(payload[position] == 0xff, 'Unsupported GRPDEF component')
                member, position = _index(payload, position + 1)
                _require(0 < member < len(segments) and member not in members,
                         'Invalid/duplicate GRPDEF segment')
                members.append(member)
            _require(bool(members), 'Empty group definition')
            groups.append((name, tuple(members)))
        elif kind == 0x8c:
            _require(not data_started and bool(payload), 'Invalid EXTDEF order/length')
            position = 0
            while position < len(payload):
                name, position = _string(payload, position)
                type_index, position = _index(payload, position)
                _require(bool(name) and type_index == 0, 'Unsupported external type/name')
                externs.append(name)
        elif kind == 0xa0:
            data_started = True
            segment, position = _index(payload, 0)
            _require(0 < segment < len(segments) and position + 2 <= len(payload),
                     'Invalid LEDATA segment/offset')
            offset = int.from_bytes(payload[position:position + 2], 'little')
            data = payload[position + 2:]
            _require(offset + len(data) <= segments[segment].size,
                     'LEDATA exceeds segment')
            writers[record_number] = (segment, offset, data)
            last = record_number
        elif kind == 0x9c:
            _require(last is not None and bool(payload), 'FIXUPP without LEDATA')
            pending.append((last, payload))
        elif kind == 0x8a:
            pass  # Exact no-entry payload/envelope checked above.
        else:
            raise ValueError(f'Unsupported OMF record {kind:02X}')

    code_indices = [i for i, s in enumerate(segments) if s is not None
                    and names[s.class_name] == 'CODE' and s.size]
    _require(len(code_indices) == 1, 'Expected one initialized CODE segment')
    code_index = code_indices[0]
    code_segment = segments[code_index]
    _require(code_segment.attributes == 0x28, 'CODE must be 16-bit byte/public')
    _require(all(names[s.name].upper() != names[code_segment.name].upper()
                 for i, s in enumerate(segments) if s is not None and i != code_index),
             'Empty declaration aliases owned CODE combine identity')
    _require(all(s.size == 0 for i, s in enumerate(segments)
                 if s is not None and i != code_index), 'Owned non-CODE storage')
    _require(all(code_index not in members for _, members in groups[1:]), 'CODE in group')
    code = bytearray(code_segment.size)
    covered = bytearray(code_segment.size)
    for segment, offset, data in writers.values():
        _require(segment == code_index or not data, 'Non-CODE initialized data')
        if segment != code_index:
            continue
        _require(not any(covered[offset:offset + len(data)]), 'Overlapping LEDATA writers')
        code[offset:offset + len(data)] = data
        covered[offset:offset + len(data)] = b'\1' * len(data)
    _require(all(covered), 'Incomplete CODE LEDATA coverage')

    def reference(method, index):
        if method == 0:
            _require(index is not None and 0 < index < len(segments), 'Invalid SEGDEF reference')
            _require(index != code_index, 'Internal CODE reference/frame')
        elif method == 1:
            _require(index is not None and 0 < index < len(groups), 'Invalid GRPDEF reference')
            _require(code_index not in groups[index][1], 'CODE-dependent group')
        elif method == 2:
            _require(index is not None and 0 < index < len(externs), 'Invalid EXTDEF reference')
        else:
            raise ValueError('Unsupported relocation reference method')

    fixups = []
    relocated = set()
    for writer, payload in pending:
        segment, base, data = writers[writer]
        _require(segment == code_index, 'Non-CODE FIXUPP')
        position = 0
        while position < len(payload):
            lead = payload[position]
            _require(lead & 128 and position + 3 <= len(payload), 'Thread/truncated FIXUPP')
            location = (lead >> 2) & 15
            _require(location in _WIDTHS, 'Unsupported fixup location')
            offset = ((lead & 3) << 8) | payload[position + 1]
            descriptor = payload[position + 2]
            position += 3
            _require(not descriptor & 0x88, 'Thread FIXUPP reference')
            frame_method = (descriptor >> 4) & 7
            frame_index = None
            if frame_method < 3:
                frame_index, position = _index(payload, position)
                reference(frame_method, frame_index)
            else:
                _require(frame_method == 5, 'Location/absolute/unsupported frame')
            target_method = descriptor & 3
            target_index, position = _index(payload, position)
            reference(target_method, target_index)
            displacement = 0
            if not descriptor & 4:
                _require(position + 2 <= len(payload), 'Truncated FIXUPP displacement')
                displacement = int.from_bytes(payload[position:position + 2], 'little')
                position += 2
            width = _WIDTHS[location]
            _require(offset + width <= len(data), 'Fixup crosses LEDATA')
            occupied = set(range(base + offset, base + offset + width))
            _require(not relocated & occupied, 'Overlapping fixups')
            relocated.update(occupied)
            fixups.append(_Fixup(base + offset, width, location, bool(lead & 64),
                                 (frame_method, frame_index), (target_method, target_index),
                                 displacement))
    return _Object(records, names, segments, groups, externs, code_index,
                   bytes(code), fixups, writers)


def _whole_control_flow(code, fixups):
    decoder = Decoder(16, code, ip=0)
    instructions, constants = [], {}
    while decoder.can_decode:
        instruction = decoder.decode()
        instructions.append(instruction)
        offsets = decoder.get_constant_offsets(instruction)
        constant_bytes = set()
        for offset, size in ((offsets.displacement_offset, offsets.displacement_size),
                             (offsets.immediate_offset, offsets.immediate_size),
                             (offsets.immediate_offset2, offsets.immediate_size2)):
            constant_bytes.update(range(instruction.ip + offset, instruction.ip + offset + size))
        constants[instruction.ip] = constant_bytes
    _require(bool(instructions) and instructions[-1].next_ip == len(code),
             'Incomplete whole CODE decode')
    boundaries = {instruction.ip for instruction in instructions}
    edges = {}
    for instruction in instructions:
        _require(instruction.code != Code.INVALID, 'Invalid whole CODE instruction')
        flow = instruction.flow_control
        if flow in (FlowControl.CONDITIONAL_BRANCH, FlowControl.UNCONDITIONAL_BRANCH):
            _require(instruction.op0_kind in (OpKind.NEAR_BRANCH16, OpKind.NEAR_BRANCH32,
                                             OpKind.NEAR_BRANCH64), 'Far branch unsupported')
            _require(instruction.near_branch_target in boundaries, 'Branch outside CODE/instruction')
            edges[instruction.ip] = [instruction.near_branch_target]
            if flow == FlowControl.CONDITIONAL_BRANCH:
                _require(instruction.next_ip in boundaries, 'Branch fallthrough outside CODE')
                edges[instruction.ip].append(instruction.next_ip)
        else:
            _require(flow in (FlowControl.NEXT, FlowControl.CALL, FlowControl.RETURN),
                     'Indirect/interrupt/exception control flow unsupported')
            _require(instruction.mnemonic != Mnemonic.HLT, 'HLT unsupported')
            if flow == FlowControl.RETURN:
                _require(instruction.mnemonic in (Mnemonic.RET, Mnemonic.RETF),
                         'Interrupt/system return unsupported')
                edges[instruction.ip] = []
            else:
                if flow == FlowControl.CALL:
                    _require(instruction.mnemonic == Mnemonic.CALL
                             and instruction.op0_kind in (OpKind.NEAR_BRANCH16,
                                                          OpKind.NEAR_BRANCH32,
                                                          OpKind.NEAR_BRANCH64,
                                                          OpKind.FAR_BRANCH16,
                                                          OpKind.FAR_BRANCH32),
                             'System/indirect call unsupported')
                _require(instruction.next_ip in boundaries, 'Fallthrough outside whole CODE')
                edges[instruction.ip] = [instruction.next_ip]
    reached, pending = set(), [0]
    while pending:
        current = pending.pop()
        if current not in reached:
            reached.add(current)
            pending.extend(edges[current])
    _require(reached == boundaries, 'Unreachable inline bytes/tables unsupported')
    for fixup in fixups:
        occupied = set(range(fixup.offset, fixup.offset + fixup.width))
        owners = [instruction for instruction in instructions
                  if instruction.ip <= fixup.offset < instruction.next_ip]
        _require(len(owners) == 1 and occupied <= constants[owners[0].ip],
                 'Fixup touches opcode/encoding instead of one instruction constant')
        _require(owners[0].flow_control not in (FlowControl.CONDITIONAL_BRANCH,
                                              FlowControl.UNCONDITIONAL_BRANCH),
                 'Relocated branch invalidates whole CODE control-flow proof')


def _validate_parts(parts, obj):
    _require(type(parts) is tuple and len(parts) == 2, 'V1 requires two partitions')
    for part in parts:
        _require(isinstance(part, CodePartition), 'Expected CodePartition')
        _require(type(part.stem) is str and _DOS_STEM.fullmatch(part.stem), 'Invalid DOS stem')
        _require(type(part.start) is int and type(part.end) is int
                 and 0 <= part.start < part.end, 'Invalid partition extent')
        _require(type(part.code_name) is str and _SEGMENT_NAME.fullmatch(part.code_name),
                 'Invalid native CODE name')
        _require(type(part.code_attributes) is int and part.code_attributes == 0x28,
                 'Native CODE must be 16-bit byte/public')
    head, tail = parts
    _require(head.stem != tail.stem and head.start == 0 and head.end == tail.start
             and tail.end == len(obj.code), 'Invalid full CODE partition coverage')
    segment = obj.segments[obj.code_index]
    _require(head.code_name == obj.names[segment.name]
             and head.code_attributes == segment.attributes, 'Head native CODE identity changed')
    _require(head.code_name.upper() != tail.code_name.upper(), 'Tail native CODE identity unchanged')
    _require(all(tail.code_name.upper() != obj.names[s.name].upper() for i, s in enumerate(obj.segments)
                 if s is not None and i != obj.code_index), 'Tail CODE name collides with declaration')
    for fixup in obj.fixups:
        _require(fixup.offset + fixup.width <= head.end, 'Crossing or tail fixup unsupported')


def partition_omf(raw: bytes, parts: tuple[CodePartition, ...]) -> dict[str, bytes]:
    """Return both complete validated OMF contributions or raise ValueError.

    ``raw`` must already have importer-owned publics removed and native external
    identities resolved. Passing a raw compiler PUBDEF object is an error.
    """
    obj = _parse(raw)
    _validate_parts(parts, obj)
    _whole_control_flow(obj.code, obj.fixups)
    result = {}
    outputs = []
    for part in parts:
        records = []
        segment_index = 0
        names_emitted = False
        # Appending a private LNAMES entry changes no retained declaration index.
        new_name_index = len(obj.names)
        segment = obj.segments[obj.code_index]
        for number, (kind, payload) in enumerate(obj.records):
            if kind == 0x96:
                if not names_emitted:
                    # Retain all original indices even when declarations were
                    # interleaved with SEGDEFs. Publish names before their use.
                    records.extend((t, b) for t, b in obj.records if t == 0x96)
                    records.append((0x96, _name_bytes(part.code_name)))
                    names_emitted = True
                continue
            elif kind == 0x98:
                segment_index += 1
                if segment_index == obj.code_index:
                    payload = (bytes((part.code_attributes,))
                               + (part.end - part.start).to_bytes(2, 'little')
                               + _encode_index(new_name_index)
                               + _encode_index(segment.class_name) + _encode_index(segment.overlay))
            elif kind == 0xa0:
                writer_segment, offset, data = obj.writers[number]
                if writer_segment == obj.code_index:
                    start, end = max(offset, part.start), min(offset + len(data), part.end)
                    if start >= end:
                        continue
                    payload = (_encode_index(obj.code_index) + (start - part.start).to_bytes(2, 'little')
                               + data[start - offset:end - offset])
            elif kind == 0x9c and part.start:
                continue
            records.append((kind, payload))
        output = b''.join(_record(kind, payload) for kind, payload in records)
        child = _parse(output)
        _require(child.code == obj.code[part.start:part.end], 'Child CODE reconstruction changed')
        _require(child.names[child.segments[child.code_index].name] == part.code_name,
                 'Child CODE name changed')
        expected = obj.fixups if part.start == 0 else []
        _require(child.fixups == expected, 'Child fixup semantics changed')
        outputs.append(child)
        result[part.stem] = output
    _require(b''.join(child.code for child in outputs) == obj.code, 'Full CODE reconstruction changed')
    _require([fixup for child in outputs for fixup in child.fixups] == obj.fixups,
             'Full fixup reconstruction changed')
    return result
