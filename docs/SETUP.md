# Setting up and rebuilding

This guide takes you from a fresh clone to a rebuilt `BCC.EXE` that is byte-identical to
Borland's. Expect about 20 minutes, most of it the DOS emulator assembling and compiling.

## 1. What you need

| Tool | Why | Install |
|---|---|---|
| Python 3.11 or later | build tools, checks | python.org, or your package manager |
| Node.js 18 or later | drives the DOS emulator | nodejs.org, `brew install node`, `apt install nodejs` |
| DOSBox-X | runs Borland's DOS compiler, assembler and linker | `brew install --cask dosbox-x`, `apt install dosbox-x`, dosbox-x.com |
| 7-Zip | unpacks the WinWorld archives | `brew install p7zip`, `apt install p7zip-full` |
| mtools | reads files off the floppy images | `brew install mtools`, `apt install mtools` |
| unzip | unpacks Borland's disk archives | usually preinstalled |

Tested on macOS (Apple silicon) and Linux. Windows users can use WSL.

## 2. Get the code

```sh
git clone --recurse-submodules https://github.com/abedegno/borland-reborn
cd borland-reborn
python3 -m venv .venv
.venv/bin/pip install -r exhume/tools/requirements.txt
```

`exhume/` is the [Exhume](https://github.com/abedegno/Exhume) toolkit, pinned as a git
submodule. If you cloned without `--recurse-submodules`, run `git submodule update --init`.

## 3. Download the original Borland programs

The build needs two Borland products. Neither is included in this repository (see
[NOTICE.md](../NOTICE.md)). Both are on [WinWorld](https://winworldpc.com), which preserves
historic software:

| Product | WinWorld page | Download to pick | Size |
|---|---|---|---|
| Borland C++ 2.0 (DOS) | [winworldpc.com/product/borland-c/20](https://winworldpc.com/product/borland-c/20) | **Borland CPP 2.0 (1991) (3.5-720k)**: eleven 3.5" 720 KB floppy images | 12 MB |
| Borland Turbo C 2.01 | [winworldpc.com/product/borland-turbo-c/2x](https://winworldpc.com/product/borland-turbo-c/2x) | **Borland Turbo C 2.01 (1989) (3.5-720k)**: three 3.5" 720 KB floppy images | 3 MB |

Pick exactly these sets. Other disk sets of the same products exist, and a different release
(even a 5.25" set) may contain different files. The setup script checks every file it
installs against [scripts/toolchain-manifest.sha256](../scripts/toolchain-manifest.sha256),
so a wrong set is caught at once. WinWorld gives the Turbo C 2.01 set's SHA-1 as
`38be5268aed873fbecea89843c79553ae77f19da`.

Borland C++ 2.0 provides the compiler `BCC.EXE` that is rebuilt, and the Borland C++ 2.0
compiler, TASM 2.51 and TLINK 4.0 that rebuild it. Turbo C 2.01 compiled 29 of BCC.EXE's
run-time library modules, so they are recompiled with it.

## 4. Install the toolchains

```sh
python3 scripts/setup-toolchains.py \
    --bc20  ~/Downloads/"Borland CPP 2.0 (1991) (3.5-720k).7z" \
    --tc201 ~/Downloads/"Borland Turbo C 2.01 (1989) (3.5-720k).7z"
```

This unpacks the floppy images into `toolchains/BC20` and `toolchains/TC201` (git ignores
both). It verifies every installed file against the manifest, then links each version's
`toolchain/` folder to them. No DOS installer is run. The command-line tools are in an
archive that Borland's installer splits across disks 3 and 8; the script joins the two parts.
You can also pass folders that hold the extracted `.IMG` files.

## 5. Generate the link inputs

```sh
cd bcc20
../.venv/bin/python scripts/prepare.py
```

The exact link needs some inputs that cannot be committed, because they are derived from
Borland's program. This step makes them on your machine from your own verified `BCC.EXE`:

- `memory_blocks/`: the original's resident code as DOS loads it;
- `groupobj/`: the link-group sources assembled with TASM;
- `linktest/`: small objects used to read TLINK's behaviour.

It takes about 10 minutes and checks every object it makes.

## 6. Build and verify everything

```sh
../.venv/bin/python ../exhume/tools/gate.py check --all
```

The gate:

1. compiles all 298 sources in DOS with the original compiler and assembler;
2. compares every function with the original executable, byte for byte (`match`);
3. checks what that comparison cannot see: every relocation target, public name, data and
   BSS layout (`verify`);
4. rebuilds the symbol table from scratch and checks it equals the committed `symbols.tsv`;
5. links the whole program with TLINK and compares the result with Borland's `BCC.EXE`.

A run ends with:

```
pass  match + verify             298/298 sources
pass  symbols.tsv from scratch   2630 names
pass  exact link                 byte-identical to the original

CHECK PASSED
```

The rebuilt executable is `build-source/SOURCELINK/run/BCC.EXE`. To see how two executables
differ, run `../exhume/tools/exediff.py FILE --original toolchain/BC20/BIN/BCC.EXE`.

## Building with changes

The exact link fixes every address, so it only proves the sources. To change them, use the
modding build, which lets TLINK lay the program out:

```sh
sh ../exhume/tools/setup-emu2.sh                      # once: the DOS emulator the comparison uses
../.venv/bin/python tools/modlink.py                  # build-source/MODLINK/run/BCC.EXE
../.venv/bin/python tools/modtest.py                  # 478 compiles, compared with Borland's BCC.EXE
cp -R src ../my-src                                   # edit the copy, then:
../.venv/bin/python tools/modlink.py --src ../my-src --out build-source/MYBUILD
```

It needs the objects that `gate.py check` compiles. [bcc20/docs/MODDING.md](../bcc20/docs/MODDING.md)
explains how it works, how it is checked and what cannot be changed yet.

## Working on one file

```sh
../.venv/bin/python ../exhume/tools/match.py src/codegen/SWITCH.C    # compile and compare one source
../.venv/bin/python ../exhume/tools/verify.py src/codegen/SWITCH.C   # check its relocations and names
../.venv/bin/python ../exhume/tools/gate.py check --fast             # every changed source, no link
```

Each source starts with its build lines: `/* target: */` names the piece of BCC.EXE it
rebuilds, `/* opts: */` gives the compiler switches, and `/* compiler: TC201 */` marks the
Turbo C modules. These lines must stay within the first 4,000 bytes of the file.

## Troubleshooting

- **`setup-toolchains: these files do not match the manifest`**: a different release or a
  damaged download. Use the exact sets named above.
- **`node is needed` / DOS runs fail**: check `node --version` and that `dosbox-x` is on your
  PATH. The emulator can be chosen with `EXHUME_DOS` (see Exhume's documentation).
- **A source no longer matches after an edit**: run `match.py SRC --dis FUNCTION` for an
  instruction diff. The code shapes that look odd in the sources are kept for the byte match;
  their comments say so (`match:` notes).
