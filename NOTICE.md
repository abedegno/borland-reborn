# Notice

Borland C++, Turbo C, Turbo Assembler and Turbo Linker are products of Borland International.
The rights to them now belong to Embarcadero Technologies. This project is not affiliated
with, endorsed by or supported by either company.

## What is in this repository

- **Recovered sources** (`*/src/`, `*/linkgroups/`, `*/reconstructed/` and the tables beside
  them): C and assembly sources reconstructed from the published binaries so that they
  rebuild those binaries byte for byte, together with the names, comments and documentation
  written while reading them, and the port's translations of them (`bcc20-port/src/` and
  the headers declaring them). They are derived from Borland's copyrighted programs. They are
  provided for study, preservation and interoperability research. **No rights in them are
  claimed or granted.** The MIT licence in `LICENSE` does not apply to them.
- **Data from BCC.EXE for the native port** (`bcc20-port/native/image.c`): the initial data,
  the inline assembler's tables and the message texts of Borland C++ 2.0's `BCC.EXE`,
  generated from the program by `bcc20-port/tools/genimage.py`, because the native compiler
  cannot run without them; the port's release binaries contain them too. Like the recovered
  sources, they are derived from Borland's program and no rights in them are claimed or
  granted.
- **Project material** (`scripts/`, the build tools, `docs/`, the READMEs and the findings):
  written for this project and licensed under the MIT licence in `LICENSE`.

## What is not in this repository

No Borland program, library, header or disk image is included, and apart from the data
above, nothing generated from them is committed (the port's call recordings, for example,
are made locally and never committed). To rebuild, you need your own copies of the original
programs. The setup guide names the WinWorld downloads used ([docs/SETUP.md](docs/SETUP.md)),
and the setup scripts check their SHA-256 hashes before anything is built.

If you hold rights in this material and have a concern, please open an issue or contact the
maintainer; it will be answered promptly.
