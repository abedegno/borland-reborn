"""exegen.py SPEC OUT.ASM FB: TASM source for one assembly module of an EXE, from a spec.
Addresses are linear offsets into the load image; each segment has a frame (paragraph)."""
import capstone, sys, struct, re, os, bisect
from capstone import x86
spec = {}; exec(open(sys.argv[1]).read(), spec)
OUT = sys.argv[2]
FB = set(int(x, 16) for x in open(sys.argv[3]).read().split()) if len(sys.argv) > 3 and os.path.exists(sys.argv[3]) else set()
_e = open(spec['EXE'], 'rb').read(); _h = struct.unpack_from('<H', _e, 8)[0] * 16; IMG = _e[_h:] + bytes(0x10000)
_n = struct.unpack_from('<H', _e, 6)[0]; _ro = struct.unpack_from('<H', _e, 0x18)[0]
RELOCS = set(sg * 16 + o for o, sg in (struct.unpack_from('<HH', _e, _ro + 4 * k) for k in range(_n)))
SEGS = spec['SEGS']            # (name, start, end, kind, decl, frame)
SEGNAME = spec['SEGNAME']      # relocated value -> text (a segment name, or "seg sym")
NAMES = spec.get('NAMES', {}); COMMENTS = spec.get('COMMENTS', {}); DATA = spec.get('DATA', {})
INLINE = set(spec.get('INLINE', ()))
CODEDATA = spec.get('CODEDATA', [])
md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_16); md.detail = True
B = lambda a, n=1: IMG[a:a + n]
def segof(a):
    for x in SEGS:
        if x[1] <= a < x[2]: return x
def hx(v):
    if v < 10: return str(v)
    s = '%Xh' % v; return ('0' + s) if s[0] in 'ABCDEF' else s
def dec(a, seg):
    return next(md.disasm(B(a, 16), a - seg[5] * 16), None)
def isbr(i): return i.mnemonic in ('call', 'jmp', 'loop', 'loope', 'loopne', 'jcxz') or i.mnemonic.startswith('j')
# ---- code: trace from entries, then sweep
codeseg = [x for x in SEGS if x[3] == 'code']
traced = {}
todo = list(spec['ENTRIES'])
while todo:
    a = todo.pop(); seg = segof(a)
    while seg and seg[3] == 'code' and seg[1] <= a < seg[2] and a not in traced:
        i = dec(a, seg)
        if i is None: break
        traced[a] = i
        if isbr(i) and i.bytes[0] not in (0x9a, 0xea) and i.operands and i.operands[0].type == x86.X86_OP_IMM:
            todo.append(seg[5] * 16 + (i.operands[0].imm & 0xFFFF))
        if i.mnemonic in ('ret', 'retf', 'jmp', 'ljmp', 'iret'): break
        if i.bytes[0] == 0xE8 and (seg[5] * 16 + (i.operands[0].imm & 0xFFFF)) in spec.get('NORETURN', ()): break
        a += i.size
        if i.bytes[0] == 0xE8 and (seg[5] * 16 + (i.operands[0].imm & 0xFFFF)) in INLINE:
            a += 1 + B(a)[0]
if spec.get('TRACE_ONLY'):
    # also: far call targets, and near call/jump targets seen in traced code, until nothing new
    while True:
        new = []
        for a, i in list(traced.items()):
            sg = segof(a)
            if i.bytes[0] in (0x9a, 0xea) and a + 3 in RELOCS:
                o_, s_ = struct.unpack_from('<HH', i.bytes, 1); t = s_ * 16 + o_
                if segof(t) and segof(t)[3] == 'code' and t not in traced: new.append(t)
        if not new: break
        todo = new
        while todo:
            a = todo.pop(); seg = segof(a)
            while seg and seg[3] == 'code' and seg[1] <= a < seg[2] and a not in traced:
                i = dec(a, seg)
                if i is None: break
                traced[a] = i
                if isbr(i) and i.bytes[0] not in (0x9a, 0xea) and i.operands and i.operands[0].type == x86.X86_OP_IMM:
                    todo.append(seg[5] * 16 + (i.operands[0].imm & 0xFFFF))
                if i.bytes[0] in (0x9a, 0xea) and a + 3 in RELOCS:
                    o_, s_ = struct.unpack_from('<HH', i.bytes, 1); todo.append(s_ * 16 + o_)
                if i.mnemonic in ('ret', 'retf', 'jmp', 'ljmp', 'iret'): break
                if i.bytes[0] == 0xE8 and (seg[5] * 16 + (i.operands[0].imm & 0xFFFF)) in spec.get('NORETURN', ()): break
                a += i.size
                if i.bytes[0] == 0xE8 and (seg[5] * 16 + (i.operands[0].imm & 0xFFFF)) in INLINE:
                    a += 1 + B(a)[0]
starts = set(traced)
# data references through DS (DSDEFAULT): split the data there and name it
DSREF = {}
if spec.get('DSDEFAULT'):
    _ds = [x for x in SEGS if x[0] == spec['DSDEFAULT']][0]
    for _s in codeseg:
        _a = _s[1]
        while _a < _s[2]:
            _i = traced.get(_a) or dec(_a, _s)
            if _i is None: _a += 1; continue
            if _a not in spec.get('DSOTHER', set()):
                for _op in _i.operands:
                    if _op.type == x86.X86_OP_MEM and _op.mem.base == 0 and _op.mem.index == 0 and _op.mem.segment in (0, x86.X86_REG_DS):
                        _t = _ds[1] + (_op.mem.disp & 0xFFFF)
                        if _t < _ds[2]: DSREF[_t] = 'v_%02X' % (_op.mem.disp & 0xFFFF)
            _a += _i.size
    for _t, _n in DSREF.items(): NAMES.setdefault(_t, _n)
items = []      # (addr, size, kind, insn)
for seg in SEGS:
    nm, s0, e0, kind, decl, fr = seg[:6]
    if kind == 'code':
        a = s0
        cd = sorted(x for x in CODEDATA if s0 <= x[0] < e0)
        while a < e0:
            hit = [x for x in cd if x[0] <= a < x[1]]
            if hit:
                cuts = sorted({a, hit[0][1]} | {x for x in DATA if a < x < hit[0][1]} | {x for x in NAMES if a < x < hit[0][1]})
                for x, y in zip(cuts, cuts[1:]): items.append((x, y - x, 'data', None))
                a = hit[0][1]; continue
            if spec.get('TRACE_ONLY') and a not in traced:
                b = a
                while b < e0 and b not in traced and not any(x[0] <= b < x[1] for x in cd): b += 1
                cuts = sorted({a, b} | {x for x in DATA if a < x < b} | {x for x in NAMES if a < x < b})
                for x, y in zip(cuts, cuts[1:]): items.append((x, y - x, 'data', None))
                a = b; continue
            i = traced.get(a) or dec(a, seg)
            if i is not None and a not in traced and (a + i.size > e0 or any(a < x < a + i.size for x in starts)): i = None
            if i is None or a in FB:
                n = i.size if (i is not None and a in FB) else 1
                items.append((a, n, 'db', i)); a += n; continue
            items.append((a, i.size, 'ins', i)); a += i.size
            if i.bytes[0] == 0xE8 and i.operands and (seg[5] * 16 + (i.operands[0].imm & 0xFFFF)) in INLINE:
                n = 1 + B(a)[0]; items.append((a, n, 'data', None)); a += n
    elif kind == 'data':
        cuts = sorted({s0, e0} | {x for x in DATA if s0 < x < e0} | {x for x in NAMES if s0 < x < e0} | {x for x in spec.get('DSPLIT', ()) if s0 < x < e0})
        for x, y in zip(cuts, cuts[1:]): items.append((x, y - x, 'data', None))
    else:
        items.append((s0, e0 - s0, 'bss', None))
items.sort()
itemat = {a: k for k, (a, n, kd, i) in enumerate(items)}
addrs = [a for a, n, kd, i in items]
def containing(v):
    k = bisect.bisect_right(addrs, v) - 1
    return items[k][0]
# ---- labels
lab = dict(NAMES)
def want(t): lab.setdefault(containing(t), NAMES.get(containing(t), 'L%05X' % containing(t)))
for t in spec['ENTRIES']: want(t)
refs = {}
for a, n, kd, i in items:
    if i is None: continue
    seg = segof(a)
    if isbr(i) and i.bytes[0] not in (0x9a, 0xea) and i.operands and i.operands[0].type == x86.X86_OP_IMM:
        t = seg[5] * 16 + (i.operands[0].imm & 0xFFFF); want(t); refs.setdefault(containing(t), set()).add(a)
    if i.bytes[0] in (0x9a, 0xea) and a + 3 in RELOCS:
        o, sg = struct.unpack_from('<HH', i.bytes, 1); t = sg * 16 + o
        if segof(t): want(t); refs.setdefault(containing(t), set()).add(a)
    for op in i.operands:
        if op.type == x86.X86_OP_MEM and op.mem.segment == x86.X86_REG_CS and op.mem.base == 0 and op.mem.index == 0:
            t = seg[5] * 16 + (op.mem.disp & 0xFFFF); want(t); refs.setdefault(containing(t), set()).add(a)
for a in spec.get('EXTRA_LABELS', ()): want(a)
for r in RELOCS:
    sg = segof(r)
    if sg is None or r < 2: continue
    sv = struct.unpack_from('<H', IMG, r)[0]; o_ = struct.unpack_from('<H', IMG, r - 2)[0]
    if B(r - 3)[0] in (0x9a, 0xea) and segof(r - 3) and segof(r-3)[3] == 'code' and (r - 3) in starts: continue
    if r - 2 in RELOCS: continue
    tseg = [x for x in SEGS if x[5] == sv and x[3] == 'code']
    if tseg and (r - 2) not in starts and not any(a2 < r < a2 + i2.size for a2, i2 in [(x, traced[x]) for x in range(r - 6, r) if x in traced]):
        t = sv * 16 + o_
        if segof(t) and segof(t)[3] == 'code' and t in starts: want(t); refs.setdefault(containing(t), set()).add(r)
# locals: a code label referenced only from inside its scope (scopes start at named labels)
codeitems = {a for a, n, kd, i in items if kd != 'data' and kd != 'bss'}
GL = set(a for a in lab if a in NAMES and a in codeitems) | {x[1] for x in codeseg}
while True:
    gls = sorted(GL)
    def scope(a): return gls[bisect.bisect_right(gls, a) - 1] if gls and a >= gls[0] else 0
    loc = {}
    for a in sorted(lab):
        if a in NAMES or a not in codeitems or a in GL: continue
        rs = refs.get(a, set())
        if all(x in codeitems and scope(x) == scope(a) and not (B(x)[0] in (0x9a, 0xea)) for x in rs) and \
           not any(segof(x)[5] * 16 + 0 and False for x in rs) and \
           not any(i2 for x in rs for i2 in [None]) :
            # memory-operand references (cs:label) keep the label global
            if any(any(op.type == x86.X86_OP_MEM for op in items[itemat[x]][3].operands) for x in rs if items[itemat[x]][3] is not None):
                continue
            loc[a] = scope(a)
    new = {a for a in lab if a in codeitems and a not in loc} - GL
    if not new: break
    GL |= new
cnt = {}
for a in sorted(loc):
    if not refs.get(a): del lab[a]; continue
    cnt[loc[a]] = cnt.get(loc[a], 0) + 1; lab[a] = '@@%d' % cnt[loc[a]]
MODS = spec.get('MODULES')     # [(file, [segment names])]
def modof(a):
    sg = segof(a)
    if not MODS or sg is None: return 0
    for k, (f, ss) in enumerate(MODS):
        if sg[0] in ss: return k
CURMOD = [0]; USES = set()      # (module, label address)
EXTERN = spec.get('EXTERN', {}); EXTUSE = set()
def ref(t):
    if t in EXTERN: EXTUSE.add((CURMOD[0] if 'CURMOD' in globals() else 0, t)); return EXTERN[t]
    c = containing(t)
    if c not in lab: return None
    if MODS and modof(c) != CURMOD[0]: USES.add((CURMOD[0], c))
    return lab[c] if t == c else '%s+%d' % (lab[c], t - c)
SEGSTART = {}
def segref(v):
    # a segment value: its name in its own module, else seg of its first label
    nm = SEGNAME.get(v)
    sgs = [x for x in SEGS if x[5] == v]
    if not MODS or not sgs or nm is None or not nm.isidentifier(): return nm
    sg = sgs[0]
    if [k for k, (f, ss) in enumerate(MODS) if sg[0] in ss][0] == CURMOD[0]:
        if sg[3] == 'code' and sg[0] in spec.get('SELFSEG', ()) and CURINS[0] > sg[1]:
            lab.setdefault(sg[1], sg[0] + '_START'); SEGSTART[sg[1]] = 1
            return 'seg ' + lab[sg[1]]
        return nm
    lab.setdefault(sg[1], sg[0] + '_START'); SEGSTART[sg[1]] = 1
    USES.add((CURMOD[0], sg[1]))
    return 'seg ' + lab[sg[1]]
# ---- instruction text
SEGREG = {x86.X86_REG_CS: 'cs:', x86.X86_REG_ES: 'es:', x86.X86_REG_SS: 'ss:', x86.X86_REG_DS: 'ds:'}
MEMNAMES = spec.get('MEMNAMES', {})     # (instruction address) -> operand text for its memory operand
def mem(op, i, a, size):
    m = op.mem; seg = segof(a)
    sr = SEGREG.get(m.segment, '')
    regs = [i.reg_name(r) for r in (m.base, m.index) if r]
    sz = {1: 'byte ptr ', 2: 'word ptr ', 4: 'dword ptr ', 6: 'fword ptr ', 8: 'qword ptr '}.get(size, '')
    if a in MEMNAMES: return sz + MEMNAMES[a]
    disp = m.disp & 0xFFFF
    if not regs:
        if m.segment == x86.X86_REG_CS:
            r = ref(seg[5] * 16 + disp)
            if r: return sz + 'cs:' + r
        DSD = spec.get('DSDEFAULT')
        if DSD and m.segment in (0, x86.X86_REG_DS) and a not in spec.get('DSOTHER', set()):
            dseg = [x for x in SEGS if x[0] == DSD][0]
            if dseg[1] + disp < dseg[2]:
                t = dseg[1] + disp
                if containing(t) not in lab: lab[containing(t)] = 'v_%02X' % disp
                r = ref(t)
                if r: return sz + ('ds:' if m.segment == x86.X86_REG_DS else '') + r
        return sz + (sr or 'ds:') + '[' + hx(disp) + ']'
    inner = '+'.join(regs)
    if m.disp:
        inner += ('-' + hx(-m.disp)) if m.disp < 0 else ('+' + hx(m.disp))
    return sz + sr + '[' + inner + ']'
IMMEXPR = spec.get('IMMEXPR', {})
CURINS = [0]
def conv(a, i):
    CURINS[0] = a
    if a in spec.get('INSTEXT', {}): return spec['INSTEXT'][a]
    m = i.mnemonic; ops = i.operands; seg = segof(a)
    m = {'cwde': 'cbw', 'cdq': 'cwd', 'popaw': 'popa', 'pushaw': 'pusha', 'int3': 'int 3'}.get(m, m)
    if m == 'int 3': return 'int\t3'
    if i.bytes[0] in (0x9a, 0xea):
        o, sg = struct.unpack_from('<HH', i.bytes, 1)
        if a + 3 not in RELOCS: return None
        t = sg * 16 + o; L = ref(t)
        if L is None: return None
        kw = 'call' if i.bytes[0] == 0x9a else 'jmp'
        if segof(t) is seg and MODS and MODS[CURMOD[0]][0] in spec.get('NOSMART_MODULES', ()): return '%s\tfar ptr %s' % (kw, L)
        if segof(t) is seg: return 'nosmart\n\t%s\tfar ptr %s\n\tsmart' % (kw, L)
        return '%s\tfar ptr %s' % (kw, L)
    if isbr(i) and ops and ops[0].type == x86.X86_OP_IMM:
        t = seg[5] * 16 + (ops[0].imm & 0xFFFF); L = ref(t) or hx(ops[0].imm & 0xFFFF)
        if m == 'jmp':
            if i.bytes[0] == 0xEB:
                if t > a: return ('jmp\t' + L, True) if (B(a + 2) == b'\x90' and containing(a + 2) not in lab) else 'jmp\tshort ' + L
                return 'jmp\t' + L
            disp = t - (a + 3)
            if -128 <= t - (a + 2) <= 127: return 'jmp\tnear ptr ' + L
            return 'jmp\t' + L
        return m + '\t' + L
    if m in ('ljmp', 'lcall'): m = {'ljmp': 'jmp', 'lcall': 'call'}[m]
    sm = re.match(r'(rep[a-z]* )?(movs|stos|lods|scas|cmps|ins|outs)([bwd])$', m)
    if sm:
        pre = sm.group(1) or ''
        over = [op.mem.segment for op in ops if op.type == x86.X86_OP_MEM and op.mem.base == x86.X86_REG_SI and op.mem.segment not in (0, x86.X86_REG_DS)]
        if over:
            sz = {'b': 'byte', 'w': 'word', 'd': 'dword'}[sm.group(3)]; sn = i.reg_name(over[0])
            o = {'movs': '%s ptr es:[di], %s:[si]' % (sz, sn), 'lods': '%s ptr %s:[si]' % (sz, sn),
                 'cmps': '%s ptr %s:[si], es:[di]' % (sz, sn), 'outs': 'dx, %s ptr %s:[si]' % (sz, sn)}.get(sm.group(2))
            if o is None: return None
            return pre + sm.group(2) + '\t' + o
        return pre + m[len(pre):]
    if m == 'xlatb':
        p = {0x2E: 'cs', 0x26: 'es', 0x36: 'ss'}.get(i.bytes[0])
        return ('xlat\tbyte ptr %s:[bx]' % p) if p else 'xlat'
    out = []
    if m == 'test' and len(ops) == 2 and all(o.type == x86.X86_OP_REG for o in ops) and i.bytes[0] in (0x84, 0x85):
        return 'test\t%s, %s' % (i.reg_name(ops[1].reg), i.reg_name(ops[0].reg))
    for k, op in enumerate(ops):
        if op.type == x86.X86_OP_REG: out.append(i.reg_name(op.reg))
        elif op.type == x86.X86_OP_MEM:
            size = op.size
            if m in ('les', 'lds', 'lss', 'lfs', 'lgs'): size = 4
            if m in ('lea', 'lgdt', 'lidt', 'sgdt', 'sidt'): size = 0 if m == 'lea' else 6
            out.append(mem(op, i, a, size))
        elif op.type == x86.X86_OP_IMM:
            w = op.size; v = op.imm & ((1 << (8 * w)) - 1 if w else 0xFFFF)
            if a in IMMEXPR: out.append(IMMEXPR[a]); continue
            r = None
            # a relocated immediate: a segment value
            p = a + i.size - w
            if w == 2 and p in RELOCS: r = segref(v)
            MS = spec.get('MSGSEG')
            if r is None and MS and w == 2 and m == 'mov' and i.reg_name(ops[0].reg) == 'dx' and a not in spec.get('NOMSG', set()):
                msg = [x for x in SEGS if x[0] == MS][0]
                if msg[1] + v in lab and lab[msg[1] + v].startswith('m_'): r = 'offset ' + lab[msg[1] + v]
            if r is None and m in ('enter', 'in', 'out', 'int', 'ret', 'retf', 'shl', 'shr', 'sar', 'sal', 'rol', 'ror', 'rcl', 'rcr'): r = hx(v)
            if r is None:
                ob = [b for b in i.bytes if b not in (0x26, 0x2e, 0x36, 0x3e, 0xf2, 0xf3, 0x66, 0x67)]
                if w == 2 and ob and ob[0] == 0x83 and v >= 0x8000: r = '-' + hx(0x10000 - v)
                else: r = hx(v)
            out.append(r)
    if m == 'xchg' and len(out) == 2 and all(op.type == x86.X86_OP_REG for op in ops): out = out[::-1]
    return (m + '\t' + ', '.join(out)).rstrip()
def strlines(b):
    parts = []; j = 0
    while j < len(b):
        k = j
        while k < len(b) and 32 <= b[k] < 127 and b[k] != 39: k += 1
        if k - j >= 3:
            k = min(k, j + 50); parts.append("'%s'" % b[j:k].decode()); j = k; continue
        parts.append(hx(b[j])); j += 1
    lines = []; cur = []
    for p in parts:
        cur.append(p)
        if len(', '.join(cur)) > 60: lines.append(cur); cur = []
    if cur: lines.append(cur)
    return lines
# ---- output
def emit(segs):
  global out, first
  out = []
  linemap = {}; skip = set()
  for seg in segs:
      nm, s0, e0, kind, decl, fr = seg[:6]
      en = seg[6] if len(seg) > 6 else nm
      out.append(''); out.append('%s\t%s' % (en, decl))
      if kind == 'code': out.append('\tassume\tcs:%s' % en)
      for a, n, kd, i in items:
          if not (s0 <= a < e0) or a in skip: continue
          if a in COMMENTS: out.append(''); out += ['; ' + l for l in COMMENTS[a].split('\n')]
          linemap[a] = len(out)
          L = lab.get(a)
          if kd == 'ins':
              r = conv(a, i)
              if isinstance(r, tuple):
                  r, pad = r
                  if pad: skip.add(a + 2)
              if r is not None and a not in FB:
                  out.append('%s\t%s' % ((L + ':') if L else '', r)); continue
              kd = 'db'
          if kd == 'db':
              ct = None
              if i is not None:
                  try: ct = conv(a, i)
                  except Exception: ct = None
                  if isinstance(ct, tuple): ct = ct[0]
              com = ('\t; ' + (ct or ('%s %s' % (i.mnemonic, i.op_str))).replace('\t', ' ').replace('\n', ' ')) if i is not None else ''
              # relocated words in a db fallback: write them as dw with the segment name
              bs = B(a, n); parts = []; k = 0
              while k < n:
                  if a + k in RELOCS and k + 1 < n:
                      if parts: out.append('%s\tdb\t%s' % ((L + ':') if L else '', ', '.join(parts))); L = None; parts = []
                      out.append('%s\tdw\t%s' % ((L + ':') if L else '', segref(struct.unpack_from('<H', bs, k)[0]))); L = None; k += 2; continue
                  parts.append(hx(bs[k])); k += 1
              if parts: out.append('%s\tdb\t%s%s' % ((L + ':') if L else '', ', '.join(parts), com))
              continue
          if kd == 'bss':
              out.append('%s\tdb\t%s dup (?)' % (L or '', hx(n))); continue
          bs = B(a, n); dk = DATA.get(a)
          if dk and dk[1]: out.append(''); out += ['; ' + l for l in dk[1].split('\n')]; linemap[a] = len(out)
          if dk and dk[0] == 'raw':
              rl = dk[2].split('\n'); out.append((L or '') + rl[0]); out += rl[1:]; continue
          # relocated words in data
          rl = [k for k in range(n - 1) if a + k in RELOCS]
          if dk and dk[0] == 'word' or rl:
              k = 0; first = True; buf = []
              def flush():
                  global first
                  if buf: out.append('%s\tdb\t%s' % ((L or '') if first else '', ', '.join(buf))); buf.clear(); first = False
              while k < n:
                  if a + k + 2 in RELOCS and k + 4 <= n and a + k + 2 not in spec.get('NODD', ()):
                      o_ = struct.unpack_from('<H', bs, k)[0]; sv = struct.unpack_from('<H', bs, k + 2)[0]
                      tseg = [x for x in SEGS if x[5] == sv]
                      tl = ref(sv * 16 + o_) if tseg else None
                      if tl and (sv * 16 + o_) in lab:
                          flush(); out.append('%s\tdd\t%s' % ((L or '') if first else '', tl)); first = False; k += 4; continue
                  if a + k in RELOCS:
                      flush(); out.append('%s\tdw\t%s' % ((L or '') if first else '', segref(struct.unpack_from('<H', bs, k)[0]))); first = False; k += 2
                  elif dk and dk[0] == 'word' and k + 1 < n:
                      flush(); out.append('%s\tdw\t%s' % ((L or '') if first else '', hx(struct.unpack_from('<H', bs, k)[0]))); first = False; k += 2
                  else:
                      buf.append(hx(bs[k])); k += 1
                      if len(buf) >= 16: flush()
              flush(); continue
          if n > 4 and len(set(bs)) == 1:
              out.append('%s\tdb\t%s dup (%s)' % (L or '', hx(n), hx(bs[0]))); continue
          for k, l in enumerate(strlines(bs)): out.append('%s\tdb\t%s' % ((L or '') if k == 0 else '', ', '.join(l)))
      if nm in spec.get('UNINIT_TAIL', {}): out.append('\tdb\t%s dup (?)' % hx(spec['UNINIT_TAIL'][nm]))
      out.append('%s\tends' % en)
  return out, linemap
def mark(out, linemap):
    if os.environ.get('MARK'):
        for a, k in linemap.items():
            ls = out[k].split('\n'); j = 0
            while j < len(ls) - 1 and (ls[j].strip() in ('nosmart', 'smart') or ls[j].strip().startswith('.')): j += 1
            ls[j] += '\t;@%05X' % a
            out[k] = '\n'.join(ls)
    return out
if not MODS:
    o, lm = emit(SEGS)
    ex_ = ['\textrn\t%s:far' % EXTERN[t] for t in sorted({t for m_, t in EXTUSE})]
    out = mark([spec.get('HEAD', '')] + ex_ + o + [spec.get('TAIL', '\tend')], {a: k + 1 + len(ex_) for a, k in lm.items()})
    open(OUT, 'w', newline='\r\n').write('\n'.join(out) + '\n')
else:
    bodies = []
    for k, (f, ss) in enumerate(MODS):
        CURMOD[0] = k
        bodies.append(emit([next(x for x in SEGS if x[0] == n) for n in ss]))
    # second pass so that segment-start labels created late are emitted
    USES.clear(); EXTUSE.clear(); bodies = []
    for k, (f, ss) in enumerate(MODS):
        CURMOD[0] = k
        bodies.append(emit([next(x for x in SEGS if x[0] == n) for n in ss]))
    for k, (f, ss) in enumerate(MODS):
        o, lm = bodies[k]
        pubs = sorted({c for (m, c) in USES if modof(c) == k})
        exts = sorted({c for (m, c) in USES if m == k})
        head = [spec.get('HEAD', '')] + (['\tnosmart'] if f in spec.get('NOSMART_MODULES', ()) else [])
        for c in pubs: head.append('\tpublic\t' + lab[c])
        for t in sorted({t for m_, t in EXTUSE if m_ == k}): head.append('\textrn\t%s:far' % EXTERN[t])
        head += spec.get('MODHEAD', {}).get(f, [])
        for c in exts:
            kd = [it for it in items if it[0] == c][0][2]
            typ = 'byte' if kd in ('data', 'bss') else 'far'
            if typ == 'far' and spec.get('NEAR_EXTRNS'):
                mysegs = set(MODS[k][1])
                rs = [r for r in refs.get(c, ()) if segof(r) and segof(r)[0] in mysegs]
                if rs and not any(B(r)[0] in (0x9a, 0xea) or r in RELOCS or (r - 2) in RELOCS for r in rs): typ = 'near'
            if c in SEGSTART: typ = 'byte'
            head.append('\textrn\t%s:%s' % (lab[c], typ))
        tail = [spec.get('TAIL', '\tend') if any(l.startswith('start:') for l in o) else '\tend']
        if f in spec.get('EXTRN_AT_END', ()):
            ex = [l for l in head if l.startswith('\textrn')]
            head = [l for l in head if not l.startswith('\textrn')]
            tail = ex + tail
        out = mark(head + o + tail, {a: n + len(head) for a, n in lm.items()})
        open(os.path.join(OUT, f), 'w', newline='\r\n').write('\n'.join(out) + '\n')

