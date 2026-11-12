"""Strict resident source-span metadata and original/native/capture provenance.

The data root is never an import root. Only trusted repository helpers located
relative to this module may supply executable code; all root inputs are data.
"""
from dataclasses import asdict, dataclass
from contextlib import ExitStack
import csv
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct
from typing import Callable


@dataclass(frozen=True)
class SpanPart:
    stem: str
    group: str
    block: str
    source_start: int
    source_end: int
    native_offset: int
    memory_offset: int
    native_file_base: int


@dataclass(frozen=True)
class SourceSpan:
    module: str
    source_record: int
    source_base: int
    source_org: int
    source_size: int
    parts: tuple[SpanPart, ...]


@dataclass(frozen=True)
class NativePart:
    part: SpanPart
    code_name: str
    code_attributes: int
    native_code_size: int
    native_sha256: str


@dataclass(frozen=True)
class ValidatedSpan:
    span: SourceSpan
    recovered: bytes
    native_parts: tuple[NativePart, ...]
    fingerprint: str


_NATIVE_CODE_NAME = re.compile(r'[A-Za-z_$?@][A-Za-z0-9_$?@]{0,254}\Z')
_DOS = re.compile(r'[A-Z_][A-Z0-9_]{0,7}\Z')
_BLOCK = re.compile(r'[A-Z_][A-Z0-9_]{0,63}\Z')
_SPAN_FIELDS = {'source_record', 'source_base', 'source_org', 'source_size', 'parts'}
_PART_FIELDS = set(SpanPart.__dataclass_fields__)


def _name(value, label, block=False):
    if not isinstance(value, str) or not (_BLOCK if block else _DOS).fullmatch(value):
        raise ValueError(f'Invalid {label}: expected uppercase DOS-safe identifier')
    return value


def _integer(value, label, minimum=0, maximum=None):
    if type(value) is not int or value < minimum or (maximum is not None and value > maximum):
        raise ValueError(f'Invalid {label}: integer out of bounds')
    return value


def _keys(value, expected, label):
    if type(value) is not dict or set(value) != expected:
        raise ValueError(f'Invalid {label} schema')


def _parse_span(module, item):
    _name(module, 'module')
    _keys(item, _SPAN_FIELDS, 'source span')
    for field in _SPAN_FIELDS - {'parts'}:
        _integer(item[field], field, 1 if field == 'source_size' else 0)
    if item['source_org'] + item['source_size'] > 0x10000:
        raise ValueError('Source IP range exceeds 16-bit segment')
    values = item['parts']
    if type(values) not in (list, tuple) or len(values) != 2:
        raise ValueError('V1 requires exactly two parts')
    parts = []
    for value in values:
        _keys(value, _PART_FIELDS, 'part')
        for field in ('stem', 'group', 'block'):
            _name(value[field], field, field == 'block')
        for field in _PART_FIELDS - {'stem', 'group', 'block'}:
            _integer(value[field], field)
        part = SpanPart(**value)
        length = part.source_end - part.source_start
        if length <= 0 or part.native_offset + length > 0x10000 or part.memory_offset + length > 0x10000:
            raise ValueError('Invalid part range')
        parts.append(part)
    head, tail = parts
    if (head.source_start != 0 or head.source_end != tail.source_start
            or tail.source_end != item['source_size'] or head.stem != module
            or tail.stem == module or head.group == tail.group or head.block == tail.block):
        raise ValueError('Parts must be ordered, contiguous, distinct native carriers')
    return SourceSpan(module, item['source_record'], item['source_base'], item['source_org'],
                      item['source_size'], tuple(parts))


def _duplicates(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'Duplicate JSON key: {key}')
        result[key] = value
    return result


def _overlap(a, b, c, d):
    return a < d and c < b


def load_source_spans(path: Path) -> dict[str, SourceSpan]:
    """Missing ledger alone means empty; existing malformed input always fails."""
    path = Path(path)
    try:
        text = path.read_text(encoding='utf-8')
    except FileNotFoundError as error:
        if path.is_symlink():
            raise ValueError("Existing source ledger has a broken link") from error
        return {}
    except (OSError, UnicodeError) as error:
        raise ValueError(f'Cannot read source ledger: {error}') from error
    try:
        data = json.loads(text, object_pairs_hook=_duplicates)
    except (ValueError, TypeError, RecursionError) as error:
        raise ValueError(f'Invalid source ledger: {error}') from error
    _keys(data, {'version', 'modules'}, 'ledger')
    if type(data['version']) is not int or data['version'] != 1 or type(data['modules']) is not dict:
        raise ValueError('Unsupported ledger version or modules')
    spans = {module: _parse_span(module, value) for module, value in data['modules'].items()}
    stems = set()
    physical = []
    native = []
    for span in spans.values():
        start, end = span.source_base, span.source_base + span.source_size
        if any(_overlap(start, end, a, b) for a, b in physical):
            raise ValueError('Overlapping source physical ranges')
        physical.append((start, end))
        for part in span.parts:
            if part.stem in stems or (part.stem in spans and part.stem != span.module):
                raise ValueError('Duplicate or colliding contribution stem')
            stems.add(part.stem)
            start, end = part.native_offset, part.native_offset + part.source_end - part.source_start
            if any(part.group == g and _overlap(start, end, a, b) for g, a, b in native):
                raise ValueError('Overlapping native contribution ranges')
            native.append((part.group, start, end))
    return spans


def _trusted_listing_bytes(path):
    # Supports tools/ adoption and private proposals independently of data ROOT.
    for ancestor in Path(__file__).resolve().parents:
        helper = ancestor / 'tools/compare_tasm_listing.py'
        if helper.is_file() and ((ancestor / 'exhume/tools/omf.py').is_file() or (ancestor.parent / 'exhume/tools/omf.py').is_file()):
            spec = importlib.util.spec_from_file_location('_source_spans_listing', helper)
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)
            with ExitStack() as files:
                # The existing parser owns no context manager; retain and close
                # its streams here without changing its parsing semantics.
                module.open = lambda *args, **kwargs: files.enter_context(open(*args, **kwargs))
                return module.listing_bytes(path)
    raise ValueError('Trusted listing helper unavailable')


def _rows(root, filename, required):
    try:
        with (root / filename).open(newline='', encoding='utf-8') as stream:
            reader = csv.DictReader(stream)
            if reader.fieldnames is None or len(set(reader.fieldnames)) != len(reader.fieldnames) or not required <= set(reader.fieldnames):
                raise ValueError(f'Invalid {filename} columns')
            rows = list(reader)
            if any(None in row or any(value is None for value in row.values()) for row in rows):
                raise ValueError(f'Malformed {filename} row')
            return rows
    except (OSError, UnicodeError, csv.Error) as error:
        raise ValueError(f'Cannot read {filename}: {error}') from error


def _number(value, base=10):
    if not isinstance(value, str) or not re.fullmatch(r'[0-9A-Fa-f]+' if base == 16 else r'[0-9]+', value):
        raise ValueError('Invalid numeric CSV field')
    return int(value, base)


def _address(value):
    if not isinstance(value, str) or not re.fullmatch(r'[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}', value):
        raise ValueError('Invalid capture address')
    return tuple(int(v, 16) for v in value.split(':'))


def _unique(rows, key, label):
    result = {}
    for row in rows:
        value = key(row)
        if value in result:
            raise ValueError(f'Duplicate {label}: {value}')
        result[value] = row
    return result


def _read(path):
    try:
        return path.read_bytes()
    except OSError as error:
        raise ValueError(f'Cannot read provenance input {path.name}: {error}') from error


def _mz(exe):
    if len(exe) < 28 or exe[:2] != b'MZ':
        raise ValueError('Invalid original MZ header')
    last, pages, count, paras = struct.unpack_from('<4H', exe, 2)
    header = paras * 16
    end = (pages - 1) * 512 + last if last else pages * 512
    table = struct.unpack_from('<H', exe, 0x18)[0]
    if (not pages or last >= 512 or header < 28 or header > end or end + 16 > len(exe)
            or (count and (table < 28 or table + 4 * count > header))):
        raise ValueError('Invalid original MZ bounds')
    if exe[end:end + 4] != b'FBOV':
        raise ValueError('Invalid original FBOV header')
    table, records = struct.unpack_from('<II', exe, end + 8)
    if not records or table < header or table + records * 8 > end:
        raise ValueError('Invalid complete original segment table bounds')
    entries = tuple(struct.unpack_from('<4H', exe, table + 8 * i) for i in range(records))
    return header, end, entries


class _Cursor:
    def __init__(self, data): self.data, self.at = data, 0
    def take(self, size):
        if size < 0 or self.at + size > len(self.data): raise ValueError('Truncated native OMF field')
        result = self.data[self.at:self.at + size]; self.at += size; return result
    def byte(self): return self.take(1)[0]
    def word(self): return struct.unpack('<H', self.take(2))[0]
    def index(self):
        n = self.byte()
        return ((n & 127) << 8) | self.byte() if n & 128 else n
    def name(self):
        try: return self.take(self.byte()).decode('ascii')
        except UnicodeError as error: raise ValueError('Non-ASCII native OMF name') from error
    def done(self):
        if self.at != len(self.data): raise ValueError('Unexpected native OMF trailing fields')
    def more(self): return self.at < len(self.data)


def _native_comment(payload):
    """Only informational forms observed in the authoritative TASM carriers."""
    if payload in (b'\x00\x00Turbo Assembler  Version 2.51',
                   b'\x40\xe9', b'\x40\xa1', b'\x40\xa2\x01'):
        return
    if payload[:2] == b'\x40\xe9':
        cursor = _Cursor(payload[2:])
        cursor.take(4)  # Producer dependency timestamp, not linker semantics.
        filename = cursor.name()
        cursor.done()
        if filename and all(32 <= ord(c) < 127 for c in filename):
            return
    raise ValueError('Unsupported or malformed native COMENT')


def _native(raw):
    """Read the narrow native carrier shape, proving every initialized CODE byte."""
    names = ['']; segments = [None]; groups = [None]; externs = [None]
    data = {}; writers = {}; fixups = []; publics = []
    target_threads = [None] * 4; frame_threads = [None] * 4
    at = 0; last = None; ended = False; first = True; header_seen = False
    def name(index):
        if not 0 <= index < len(names): raise ValueError('Invalid native name index')
        return names[index]
    while at < len(raw):
        if ended or at + 3 > len(raw): raise ValueError('Native OMF truncated or trailing bytes')
        kind = raw[at]; length = int.from_bytes(raw[at+1:at+3], 'little'); stop = at + 3 + length
        if length < 1 or stop > len(raw) or sum(raw[at:stop]) & 255:
            raise ValueError('Native OMF checksum or record bounds')
        cursor = _Cursor(raw[at+3:stop-1]); at = stop
        if first and kind != 0x80: raise ValueError('Native OMF missing THEADR')
        first = False
        if kind == 0x80:
            if header_seen: raise ValueError('Duplicate native OMF module')
            header_seen = True
            cursor.name(); cursor.done()
        elif kind == 0x88:
            _native_comment(cursor.data)
        elif kind == 0x96:
            while cursor.more(): names.append(cursor.name())
        elif kind == 0x98:
            attrs = cursor.byte()
            if (attrs >> 5) == 0: raise ValueError('Absolute native segments unsupported')
            size = cursor.word(); sn, cn, on = cursor.index(), cursor.index(), cursor.index(); cursor.done()
            if attrs & 3: raise ValueError('32-bit or BIG native segment unsupported')
            segments.append((name(sn), name(cn), size, attrs)); name(on)
            data[len(segments)-1] = bytearray(size); writers[len(segments)-1] = bytearray(size)
        elif kind == 0x9a:
            group_name = name(cursor.index()); members = []
            while cursor.more():
                if cursor.byte() != 255: raise ValueError('Unsupported native group component')
                members.append(cursor.index())
            groups.append((group_name, members))
        elif kind in (0x8c, 0xb4):
            while cursor.more(): externs.append(cursor.name()); cursor.index()
        elif kind == 0x90:
            group, segment = cursor.index(), cursor.index()
            if segment == 0: raise ValueError('Absolute native public unsupported')
            while cursor.more():
                public = cursor.name(); offset = cursor.word(); cursor.index(); publics.append((group,segment,offset,public))
        elif kind == 0xa0:
            segment, offset = cursor.index(), cursor.word(); chunk = cursor.take(len(cursor.data)-cursor.at)
            if segment not in data or offset + len(chunk) > len(data[segment]): raise ValueError('Native LEDATA exceeds segment')
            if any(writers[segment][offset:offset+len(chunk)]): raise ValueError('Overlapping native LEDATA writers')
            data[segment][offset:offset+len(chunk)] = chunk; writers[segment][offset:offset+len(chunk)] = b'\1' * len(chunk)
            last = (segment, offset, len(chunk))
        elif kind == 0x9c:
            while cursor.more():
                c = cursor.byte()
                if not c & 128:
                    method = (c >> 2) & 7; datum = cursor.index() if method < 3 else None
                    if (c & 32) or (method > 5 if c & 64 else method > 3): raise ValueError('Unsupported native thread')
                    (frame_threads if c & 64 else target_threads)[c & 3] = (method, datum)
                    continue
                if last is None: raise ValueError('Native FIXUPP without LEDATA')
                location = (c >> 2) & 15; offset = ((c & 3) << 8) | cursor.byte()
                width = {0:1,1:2,2:2,3:4,4:1,5:2}.get(location)
                if width is None or offset + width > last[2]: raise ValueError('Unsupported or crossing native FIXUPP')
                fd = cursor.byte()
                if fd & 128: frame = frame_threads[(fd >> 4) & 3]
                else:
                    method = (fd >> 4) & 7; frame = (method, cursor.index() if method < 3 else None)
                if fd & 8:
                    target = target_threads[fd & 3]
                    if target is not None: target = (target[0] & 3,target[1])
                else: target = (fd & 3, cursor.index())
                if frame is None or target is None: raise ValueError('Undefined native fixup thread')
                if not fd & 4: cursor.word()
                fixups.append((last[0], last[1]+offset, width, frame, target))
        elif kind == 0x8a:
            if cursor.byte() != 0: raise ValueError('Native entry point unsupported')
            cursor.done(); ended = True
        else:
            raise ValueError(f'Unsupported native OMF record {kind:02X}')
    if not ended: raise ValueError('Native OMF missing MODEND')
    code = [i for i,s in enumerate(segments) if s and s[1] == 'CODE']
    if len(code) != 1: raise ValueError('Native carrier requires sole CODE')
    code = code[0]; code_name, _, size, attrs = segments[code]
    if not _NATIVE_CODE_NAME.fullmatch(code_name):
        raise ValueError('Invalid native CODE name: expected OMF identifier')
    if attrs != 0x28 or not size or not all(writers[code]):
        raise ValueError('Native CODE requires complete 16-bit byte/public initialized coverage')
    for i, segment in enumerate(segments):
        if segment and i != code and (segment[1] != 'DATA' or segment[2]):
            raise ValueError('Owned native DATA/BSS unsupported')
    for group_name, members in groups[1:]:
        if group_name != 'DGROUP' or any(not 0 < i < len(segments) or i == code for i in members) or len(set(members)) != len(members):
            raise ValueError('Unsupported native group')
    for group, segment, offset, public in publics:
        if not 0 <= group < len(groups) or not 0 < segment < len(segments) or offset > segments[segment][2]:
            raise ValueError('Invalid native public coordinates')
        if group and segment not in groups[group][1]:
            raise ValueError('Native public segment is not a member of its group')
    mask = bytearray(size)
    def reference(method, index, frame=False):
        if method in (0,1,2):
            values = (segments,groups,externs)[method]
            if index is None or not 0 < index < len(values): raise ValueError('Invalid native fixup index')
        elif not frame or method not in (4,5): raise ValueError('Unsupported native fixup reference')
    for segment, offset, width, frame, target in fixups:
        reference(*frame,frame=True); reference(*target)
        if segment != code: raise ValueError('Native fixups in owned data unsupported')
        if any(mask[offset:offset+width]): raise ValueError('Overlapping native fixup locations')
        mask[offset:offset+width] = b'\1' * width
    return code_name, attrs, bytes(data[code]), bytes(mask)


def validate_source_span(root: Path, span: SourceSpan, resident_fixups: Callable) -> ValidatedSpan:
    """Prove a full resident source from its original table and two native carriers."""
    root = Path(root)
    try:
        # Frozen types are an API convenience, not a bypass around schema validation.
        if type(span) is not SourceSpan or type(span.parts) is not tuple or any(type(p) is not SpanPart for p in span.parts):
            raise ValueError('Invalid source-span model')
        raw_span = asdict(span); module = raw_span.pop('module'); checked = _parse_span(module, raw_span)
        if checked != span: raise ValueError('Invalid source-span model')
        inputs = {}
        def read(relative):
            data = _read(root / relative); inputs[str(relative)] = hashlib.sha256(data).hexdigest(); return data
        def rows(relative, fields):
            # Hash exactly the bytes consumed; reject concurrent input mutation below.
            read(relative); return _rows(root,relative,set(fields.split(',')))
        modules = rows('module-addresses.csv','listing,block,segment,offset,size')
        by_module = _unique(modules, lambda r: Path(r['listing']).stem.upper(), 'module row')
        if span.module not in by_module: raise ValueError('Declared span owner missing module row')
        row = by_module[span.module]
        blocks = _unique(rows('memory_blocks/index.csv','block,start,end,size,file'),lambda r:r['block'],'capture block')
        layouts = rows('group-layout.csv','object,block,overlay')
        groups = _unique(layouts,lambda r:r['object'],'native group')
        _unique(layouts,lambda r:r['block'],'group block')
        accepted = rows('source-modules.csv','module,name')
        accepted_stems = {r['module'].upper() for r in accepted}
        child = span.parts[1].stem
        baseline_stems = {p.stem.upper() for directory in ('groupobj','linktest') for p in (root/directory).glob('*') if p.suffix.upper()=='.OBJ'}
        if child in accepted_stems or child in baseline_stems or child in by_module:
            raise ValueError('Child stem collides with existing source or native/link object')
        exe = read('toolchain/BC20/BIN/BCC.EXE')
        header, end, entries = _mz(exe)
        head = span.parts[0]
        if head.block not in blocks: raise ValueError('Unknown source capture block')
        segment, origin = _address(blocks[head.block]['start'])
        if segment < 0x1000: raise ValueError('Resident capture precedes load paragraph')
        paragraph = segment - 0x1000
        if (row['block'] != head.block or _number(row['segment'],16) != segment
                or _number(row['offset'],16) != span.source_org or _number(row['size']) != span.source_size
                or span.source_base != header + paragraph * 16 + span.source_org):
            raise ValueError('Source row/header geometry disagrees with ledger')
        candidates = [i for i,(para,maximum,flags,minimum) in enumerate(entries)
                      if para == paragraph and minimum <= span.source_org and span.source_org + span.source_size <= maximum]
        if candidates != [span.source_record] or entries[span.source_record][2] != 1:
            raise ValueError('Source must have unique exact flags1 original same-CS record')
        for para, maximum, flags, minimum in entries:
            if flags not in (0,1,3,4): raise ValueError('Unsupported original segment table flags')
            if flags == 1 and (minimum > maximum or header + para * 16 + maximum > end):
                raise ValueError('Invalid original resident segment bounds')
        if not header <= span.source_base < span.source_base + span.source_size <= end:
            raise ValueError('Source outside original resident image')
        recovered = bytearray(); natives = []; native_ranges = []
        for part in span.parts:
            if part.group not in groups or part.block not in blocks:
                raise ValueError('Unknown declared native group/capture')
            layout, block = groups[part.group], blocks[part.block]
            if layout['overlay'] != '0' or layout['block'] != part.block:
                raise ValueError('Only matching resident native carriers supported')
            seg, off = _address(block['start']); endseg, endoff = _address(block['end']); size = _number(block['size'])
            filename = block['file']
            if (Path(filename).name != filename or not re.fullmatch(r'[A-Za-z0-9_.-]+',filename)
                    or filename in ('.','..') or seg < 0x1000 or endseg != seg or endoff < off or size != endoff-off+1):
                raise ValueError('Invalid capture file/address geometry')
            memory = read(Path('memory_blocks') / filename)
            if len(memory) != size: raise ValueError('Capture file size disagrees with index')
            physical = header + (seg - 0x1000) * 16 + off
            length = part.source_end-part.source_start
            source = span.source_base+part.source_start
            if (physical < header or physical+size > end or part.memory_offset+length > size
                    or physical+part.memory_offset != source or part.native_file_base+part.native_offset != source):
                raise ValueError('Native/capture/source physical identities disagree')
            raw = read(Path('groupobj') / f'{part.group}.OBJ')
            code_name, attrs, code, mask = _native(raw)
            if (part.native_file_base < header or part.native_file_base+len(code) > end
                    or part.native_offset+length > len(code)):
                raise ValueError('Native full CODE geometry exceeds original bounds')
            native_end = part.native_file_base + len(code)
            if not physical <= part.native_file_base < native_end <= physical + size:
                raise ValueError('Native full CODE exceeds its capture bounds')
            if any(_overlap(part.native_file_base,native_end,a,b) for a,b in native_ranges):
                raise ValueError('Full native carrier CODE ranges overlap')
            native_ranges.append((part.native_file_base,native_end))
            original = exe[part.native_file_base:native_end]
            if any(a!=b and not mask[i] for i,(a,b) in enumerate(zip(code,original))):
                raise ValueError('Native fixed bytes disagree with original full CODE')
            if part is span.parts[1] and any(mask[part.native_offset:part.native_offset+length]):
                raise ValueError('Native tail fixups unsupported')
            recovered.extend(memory[part.memory_offset:part.memory_offset+length])
            natives.append(NativePart(part,code_name,attrs,len(code),hashlib.sha256(raw).hexdigest()))
        recovered = bytes(recovered)
        # The pure existing callback validates every MZ relocation and exact +1000h
        # loaded WORD before any more permissive listing masks are considered.
        mz_masks = resident_fixups(exe,span.source_base,recovered)
        if not isinstance(mz_masks,(set,frozenset)) or any(type(i) is not int or not 0 <= i < span.source_size for i in mz_masks):
            raise ValueError('Invalid resident relocation mask result')
        cut = span.parts[0].source_end
        if any(i >= cut for i in mz_masks): raise ValueError('Crossing or tail original MZ relocation unsupported')
        original = exe[span.source_base:span.source_base+span.source_size]
        if len(recovered) != span.source_size or any(a!=b and i not in mz_masks for i,(a,b) in enumerate(zip(original,recovered))):
            raise ValueError('Loaded/original fixed bytes disagree')
        listing_path = Path('reconstructed') / f'{span.module}.LST'
        read(listing_path)
        listing, masks = _trusted_listing_bytes(root/listing_path)
        if len(listing) != span.source_size or any(a!=b and i not in masks for i,(a,b) in enumerate(zip(listing,recovered))):
            raise ValueError('Full reconstructed listing disagrees with loaded source')
        # All resident mapped owners, including aliased capture blocks, are checked
        # in physical space. A distinct block name cannot hide another owner.
        resident_blocks = {layout['block'] for layout in layouts if layout['overlay'] == '0'}
        for name, other in by_module.items():
            if name == span.module or other['block'] not in resident_blocks: continue
            if other['block'] not in blocks: raise ValueError('Unknown overlapping source block')
            seg, off = _address(blocks[other['block']]['start'])
            if seg < 0x1000 or _number(other['segment'],16) != seg: raise ValueError('Existing source row segment disagrees with capture')
            org, size = _number(other['offset'],16), _number(other['size'])
            if size <= 0 or org < off or org + size > 0x10000: raise ValueError('Invalid existing source ownership range')
            base = header + (seg-0x1000)*16 + org
            if _overlap(base,base+size,span.source_base,span.source_base+span.source_size):
                raise ValueError('Existing source ownership overlaps declared full source')
        for relative, digest in inputs.items():
            if hashlib.sha256(_read(root/relative)).hexdigest() != digest:
                raise ValueError('Provenance input changed during validation')
        fingerprint = hashlib.sha256(json.dumps({'span':asdict(span),'inputs':inputs},sort_keys=True,separators=(',',':')).encode()).hexdigest()
        return ValidatedSpan(span,recovered,tuple(natives),fingerprint)
    except (KeyError, IndexError, TypeError, AttributeError, struct.error, OverflowError, UnicodeError, OSError) as error:
        raise ValueError(f'Invalid source-span provenance: {error}') from error
