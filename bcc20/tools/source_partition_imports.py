"""Plan source owners and stage complete cross-carrier transformations in memory."""
from collections import defaultdict
from dataclasses import dataclass
import hashlib
from pathlib import Path
import tempfile
from cross_carrier_omf import CodePartition
from native_placements import ValidatedPlacement


@dataclass(frozen=True)
class Contribution:
    owner: str
    stem: str
    marker: str
    group: str
    native_offset: int
    partition_index: int | None


@dataclass(frozen=True)
class PreparedPartition:
    objects: dict
    replacements: dict
    absolutes: dict
    proof: dict


def plan_contributions(selected, module_rows, group_rows, block_starts,
                       validated, listing_stems, accepted, reserved, *, placements=None):
    placements = {} if placements is None else placements
    if set(placements) & set(validated):
        raise ValueError("Ordinary native placement conflicts with source partition")
    for owner, checked in placements.items():
        if type(checked) is not ValidatedPlacement or checked.placement.module != listing_stems.get(owner, owner):
            raise ValueError("Invalid validated ordinary placement")
    if len(selected) != len(set(selected)):
        raise ValueError('Duplicate selected source owner')
    protected = {s.upper() for s in reserved} | {s.upper() for s in accepted}
    tails = set()
    # Reserve tails for inactive owners too: activation cannot alter identity.
    for owner, checked in validated.items():
        if checked.span.module != owner:
            raise ValueError('Source partition owner mismatch')
        for part in checked.span.parts[1:]:
            if part.stem.upper() in protected | tails:
                raise ValueError(f'Partition stem collision: {part.stem}')
            tails.add(part.stem.upper())
    result = defaultdict(list)
    used = set()
    for owner in selected:
        if owner in validated:
            contributions = [Contribution(owner, p.stem, p.stem, p.group, p.native_offset, i)
                             for i,p in enumerate(validated[owner].span.parts)]
        else:
            marker = listing_stems.get(owner, owner)
            row = module_rows[marker]
            group = group_rows[row['block']]
            base = int(row['offset'],16) - block_starts[row['block']]
            if owner in placements:
                placement = placements[owner].placement
                if marker != placement.module or placement.group != group or placement.block != row['block'] or placement.source_org != int(row['offset'],16):
                    raise ValueError('Ordinary contribution disagrees with validated placement')
                base = placement.native_offset
            contributions = [Contribution(owner, owner, marker, group, base, None)]
        for c in contributions:
            if c.stem in used:
                raise ValueError(f'Duplicate source contribution: {c.stem}')
            used.add(c.stem)
            result[c.group].append(c)
    return dict(result)


def prepare_partition(checked, head_block, aliases, symbols, staging_parent,
                      transform, split, *, compiler_bytes=None):
    """Transform once at the proved native head offset; publish nothing here."""
    span = checked.span
    head = span.parts[0]
    with tempfile.TemporaryDirectory(prefix='source-partition-',dir=staging_parent) as d:
        options = {"output_dir": Path(d)}
        if compiler_bytes is not None:
            if type(compiler_bytes) is not bytes or not compiler_bytes:
                raise ValueError('Empty or invalid immutable compiler object')
            options['source_bytes'] = compiler_bytes
        output, replacements, absolutes = transform(span.module, head.group,
            head.native_offset, head_block, aliases, symbols, **options)
        raw = output.read_bytes()
        parts = tuple(CodePartition(p.part.stem, p.part.source_start, p.part.source_end,
                                    p.code_name, p.code_attributes)
                      for p in checked.native_parts)
        objects = split(raw, parts)
        if set(objects) != {p.stem for p in span.parts} or any(
                type(b) is not bytes or not b for b in objects.values()):
            raise ValueError('Incomplete partition output')
        digest = lambda b: hashlib.sha256(b).hexdigest()
        proof = dict(owner=span.module, fingerprint=checked.fingerprint,
                     transformed_sha256=digest(raw),
                     parts=[dict(stem=p.stem, group=p.group, start=p.source_start,
                                 end=p.source_end, size=p.source_end-p.source_start,
                                 native_offset=p.native_offset,
                                 object_sha256=digest(objects[p.stem])) for p in span.parts])
        if compiler_bytes is not None:
            proof['compiler_sha256'] = digest(compiler_bytes)
        return PreparedPartition(objects, replacements, absolutes, proof)


def source_object_owners(accepted, validated, proof, object_dir):
    """Map linked stems to accepted owners only after current provenance proof."""
    expected = set(accepted) & set(validated)
    if (type(proof) is not dict or proof.get('version') != 1
            or type(proof.get('modules')) is not dict or set(proof['modules']) != expected):
        raise ValueError('Partition accounting proof owners disagree')
    owners = {m:m for m in accepted}
    for module in expected:
        checked = validated[module]; entry = proof['modules'][module]
        if (entry.get('owner') != module or entry.get('fingerprint') != checked.fingerprint
                or type(entry.get('parts')) is not list
                or len(entry['parts']) != len(checked.span.parts)):
            raise ValueError('Stale partition accounting proof')
        for p, recorded in zip(checked.span.parts,entry['parts']):
            wanted = dict(stem=p.stem, group=p.group, start=p.source_start,
                          end=p.source_end, size=p.source_end-p.source_start,
                          native_offset=p.native_offset)
            if any(recorded.get(k) != v for k,v in wanted.items()):
                raise ValueError('Partition accounting geometry disagrees')
            raw = (object_dir/f'{p.stem}.OBJ').read_bytes()
            if recorded.get('object_sha256') != hashlib.sha256(raw).hexdigest():
                raise ValueError('Stale partition object in accounting')
            if p.stem in owners and owners[p.stem] != module:
                raise ValueError('Partition accounting ownership collision')
            owners[p.stem] = module
    return owners


def publish_partition(objects, object_dir):
    """Stage the complete set; roll back all final children on publication error."""
    targets = [object_dir/f'{stem}.OBJ' for stem in objects]
    try:
        with tempfile.TemporaryDirectory(prefix='publish-partition-',dir=object_dir) as d:
            stage = Path(d)
            for stem, raw in objects.items():
                (stage/f'{stem}.OBJ').write_bytes(raw)
            for stem in objects:
                (stage/f'{stem}.OBJ').replace(object_dir/f'{stem}.OBJ')
    except BaseException:
        for path in targets:
            path.unlink(missing_ok=True)
        raise
