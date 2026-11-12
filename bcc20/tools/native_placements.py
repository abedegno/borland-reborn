"""Explicit ordinary resident placement, proved from original/native/capture geometry.

This changes no source extent or ownership and infers no offsets from minima.
All executable parsers come from the trusted source_spans sibling, never data ROOT.
"""
from dataclasses import dataclass,asdict
from pathlib import Path
import hashlib,json,struct
import source_spans as s

@dataclass(frozen=True)
class NativePlacement:
    module: str
    source_record: int
    block: str
    group: str
    source_base: int
    source_org: int
    source_size: int
    native_offset: int
    native_file_base: int
    native_size: int
    code_name: str
    code_attributes: int
    native_sha256: str

@dataclass(frozen=True)
class ValidatedPlacement:
    placement: NativePlacement
    recovered: bytes
    fingerprint: str

_FIELDS=set(NativePlacement.__dataclass_fields__)-{'module'}
def _parse(module,item):
    s._name(module,'placement module');s._keys(item,_FIELDS,'native placement')
    for key in ('block','group'):s._name(item[key],key,key=='block')
    if type(item['code_name']) is not str or not s._NATIVE_CODE_NAME.fullmatch(item['code_name']):
        raise ValueError('Invalid placement native CODE name')
    if type(item['native_sha256']) is not str or not s.re.fullmatch(r'[0-9a-f]{64}',item['native_sha256']):
        raise ValueError('Invalid audited native object SHA256')
    for key in _FIELDS-{'block','group','code_name','native_sha256'}:
        s._integer(item[key],key,1 if key in ('source_size','native_size') else 0)
    if (item['source_org']+item['source_size']>0x10000
            or item['native_offset']+item['source_size']>item['native_size']
            or item['native_size']>0x10000 or item['code_attributes']!=0x28):
        raise ValueError('Invalid explicit native placement bounds/attributes')
    return NativePlacement(module,**item)

def load_native_placements(path):
    path=Path(path)
    try:text=path.read_text(encoding='utf8')
    except FileNotFoundError as e:
        if path.is_symlink():raise ValueError('Broken native placement ledger') from e
        return {}
    except (OSError,UnicodeError) as e:raise ValueError('Cannot read native placements') from e
    try:
        data=json.loads(text,object_pairs_hook=s._duplicates)
        s._keys(data,{'version','modules'},'native placements')
        if type(data['version']) is not int or data['version']!=1 or type(data['modules']) is not dict:
            raise ValueError('Unsupported native placement schema')
        result={m:_parse(m,v) for m,v in data['modules'].items()}
        previous=[]
        for v in result.values():
            if any(s._overlap(v.source_base,v.source_base+v.source_size,p.source_base,p.source_base+p.source_size)
                   or (v.group==p.group and s._overlap(v.native_offset,v.native_offset+v.source_size,p.native_offset,p.native_offset+p.source_size))
                   for p in previous):raise ValueError('Overlapping explicit native placements')
            previous.append(v)
        return result
    except (TypeError,RecursionError) as e:raise ValueError('Invalid native placements') from e

def validate_native_placement(root,placement,resident_fixups):
    """Return one immutable ordinary contribution only after full original proof."""
    root=Path(root)
    try:
        if type(placement) is not NativePlacement:raise ValueError('Invalid native placement model')
        value=asdict(placement);module=value.pop('module')
        if _parse(module,value)!=placement:raise ValueError('Invalid native placement model')
        p=placement;inputs={}
        def read(relative):
            raw=s._read(root/relative);inputs[str(relative)]=hashlib.sha256(raw).hexdigest();return raw
        def rows(relative,fields):
            read(relative);return s._rows(root,relative,set(fields.split(',')))
        modules=s._unique(rows('module-addresses.csv','listing,block,segment,offset,size'),lambda r:Path(r['listing']).stem.upper(),'module row')
        blocks=s._unique(rows('memory_blocks/index.csv','block,start,end,size,file'),lambda r:r['block'],'capture block')
        layouts=rows('group-layout.csv','object,block,overlay')
        groups=s._unique(layouts,lambda r:r['object'],'native group');s._unique(layouts,lambda r:r['block'],'group block')
        row=modules[p.module];block=blocks[p.block];group=groups[p.group]
        if group['block']!=p.block or group['overlay']!='0':raise ValueError('Placement must use matching resident group')
        seg,origin=s._address(block['start']);endseg,endoff=s._address(block['end']);size=s._number(block['size'])
        name=block['file']
        if (seg<0x1000 or endseg!=seg or endoff<origin or size!=endoff-origin+1
                or Path(name).name!=name or not s.re.fullmatch(r'[A-Za-z0-9_.-]+',name) or name in ('.','..')):
            raise ValueError('Invalid placement capture geometry')
        exe=read('toolchain/BC20/BIN/BCC.EXE');header,end,entries=s._mz(exe)
        para=seg-0x1000;physical=header+para*16+origin
        if (row['block']!=p.block or s._number(row['segment'],16)!=seg
                or s._number(row['offset'],16)!=p.source_org or s._number(row['size'])!=p.source_size
                or p.source_base!=header+para*16+p.source_org):
            raise ValueError('Explicit placement disagrees with original module row')
        choices=[i for i,(a,b,c,d) in enumerate(entries) if a==para and d<=p.source_org and p.source_org+p.source_size<=b]
        if choices!=[p.source_record] or entries[p.source_record][2]!=1:
            raise ValueError('Placement needs unique original flags1 same-CS source record')
        for a,b,c,d in entries:
            if c not in (0,1,3,4) or (c==1 and (d>b or header+16*a+b>end)):
                raise ValueError('Invalid original resident segment bounds')
        if not header<=physical<physical+size<=end:raise ValueError('Capture exceeds original resident image')
        memory=read(Path('memory_blocks')/name)
        if len(memory)!=size:raise ValueError('Capture size mismatch')
        def verify_loaded(base,loaded):
            masks=resident_fixups(exe,base,loaded)
            if (not isinstance(masks,(set,frozenset)) or any(type(i) is not int or not 0<=i<len(loaded) for i in masks)
                    or len(exe[base:base+len(loaded)])!=len(loaded)
                    or any(a!=b and i not in masks for i,(a,b) in enumerate(zip(exe[base:base+len(loaded)],loaded)))):
                raise ValueError('Loaded capture differs from original/MZ words')
            return masks
        verify_loaded(physical,memory)
        raw=read(Path('groupobj')/(p.group+'.OBJ'))
        if hashlib.sha256(raw).hexdigest()!=p.native_sha256:
            raise ValueError('Native object disagrees with audited identity pin')
        code_name,attrs,code,mask=s._native(raw)
        if (code_name!=p.code_name or attrs!=p.code_attributes or len(code)!=p.native_size
                or not physical<=p.native_file_base<p.native_file_base+len(code)<=physical+size
                or p.native_file_base+p.native_offset!=p.source_base):
            raise ValueError('Explicit native carrier/source placement geometry mismatch')
        lo=p.native_file_base-physical;loaded_native=memory[lo:lo+len(code)]
        mz=verify_loaded(p.native_file_base,loaded_native)
        if any(mask[i] and i not in mz for i in range(len(code))):
            raise ValueError('Native relocation masks exceed original MZ fields')
        original=exe[p.native_file_base:p.native_file_base+len(code)]
        if any(a!=b and not mask[i] for i,(a,b) in enumerate(zip(code,original))):
            raise ValueError('Native full CODE fixed bytes disagree with original')
        source_at=p.source_base-physical
        if source_at<0 or source_at+p.source_size>len(memory):raise ValueError('Source exceeds capture')
        recovered=memory[source_at:source_at+p.source_size];source_mz=verify_loaded(p.source_base,recovered)
        path=Path('reconstructed')/(p.module+'.LST');read(path)
        listing,masks=s._trusted_listing_bytes(root/path)
        if (len(listing)!=p.source_size or not set(masks)<=source_mz
                or any(a!=b and i not in masks for i,(a,b) in enumerate(zip(listing,recovered)))):
            raise ValueError('Complete placement listing disagrees with loaded source')
        resident={r['block'] for r in layouts if r['overlay']=='0'}
        for owner,other in modules.items():
            if owner==p.module or other['block'] not in resident:continue
            other_block=blocks[other['block']];os,oo=s._address(other_block['start'])
            org,count=s._number(other['offset'],16),s._number(other['size'])
            if os<0x1000 or s._number(other['segment'],16)!=os or count<=0 or org<oo or org+count>0x10000:
                raise ValueError('Invalid existing resident owner geometry')
            base=header+(os-0x1000)*16+org
            if s._overlap(base,base+count,p.source_base,p.source_base+p.source_size):
                raise ValueError('Existing owner overlaps explicit ordinary placement')
        for name,digest in inputs.items():
            if hashlib.sha256(s._read(root/name)).hexdigest()!=digest:raise ValueError('Placement provenance changed during validation')
        fingerprint=hashlib.sha256(json.dumps(dict(placement=asdict(p),inputs=inputs),sort_keys=True,separators=(',',':')).encode()).hexdigest()
        return ValidatedPlacement(p,recovered,fingerprint)
    except (KeyError,IndexError,TypeError,AttributeError,struct.error,OverflowError,UnicodeError,OSError) as e:
        raise ValueError(f'Invalid native placement provenance: {e}') from e
