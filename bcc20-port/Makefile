# The port of BCC.EXE: build/replay, the harness that checks translated functions against
# calls recorded in Borland's BCC.EXE (README.md).
CC ?= cc
CFLAGS ?= -std=c11 -O2 -g -fPIC -Wall -Wextra -Wno-missing-field-initializers \
          -Werror=implicit-function-declaration
# _DEFAULT_SOURCE: glibc declares POSIX functions (fork, opendir ...) under -std=c11 only then
CPPFLAGS += -Iinclude -Ireplay -D_DEFAULT_SOURCE

SRC := $(sort $(wildcard src/*/*.c))
REPLAY := replay/replay.c replay/functions.c
OBJ := $(patsubst %.c,build/obj/%.o,$(SRC) $(REPLAY)) build/obj/adapters.o

build/replay: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# the generated adapters (tools/genadapters.py): committed, since making them needs BCC.EXE
# (for its code addresses); remade when the toolchain is installed for ../bcc20
ADAPTERS := generated/adapters.c
ifneq ($(wildcard ../bcc20/toolchain/BC20/BIN/BCC.EXE),)
$(ADAPTERS): tools/genadapters.py tools/record.py $(SRC)
	python3 tools/genadapters.py adapters $@
endif

build/obj/adapters.o: $(ADAPTERS) $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

build/obj/%.o: %.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# the native build (README.md, "Plan", step 3): the translations with native/ in place of
# the replay harness
NATIVE := $(sort $(wildcard native/*.c))
NATIVE_OBJ := $(patsubst %.c,build/native/%.o,$(SRC) $(NATIVE)) build/native/adapters.o

build/bcc: $(NATIVE_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

build/native/adapters.o: $(ADAPTERS) $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE $(CFLAGS) -c -o $@ $<

# (before the general rule: make 3.81 takes the first that matches) the translations
# report each call to native/stack.c, which models BCC.EXE's stack
build/native/src/%.o: src/%.c $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE $(CFLAGS) -finstrument-functions -c -o $@ $<

build/native/%.o: %.c $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE $(CFLAGS) -c -o $@ $<

.PHONY: native
native: build/bcc

# the library (include/bcc20.h): the native build's objects, native.c without main
LIB_OBJ := $(filter-out build/native/native/native.o,$(NATIVE_OBJ)) build/lib/native.o

build/lib/native.o: native/native.c $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE -DBCC20_LIBRARY $(CFLAGS) -c -o $@ $<

# one relocatable object first, so that the real definitions win over the generated
# stand-ins (weak) inside it: an archive would only pull a member for an undefined name
build/libbcc20.a: $(LIB_OBJ)
	rm -f $@
	$(CC) -r -nostdlib -o build/lib/bcc20.o $^
	ar rcs $@ build/lib/bcc20.o

build/bcc20run: tools/bcc20run.c build/libbcc20.a include/bcc20.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ tools/bcc20run.c build/libbcc20.a

# the same as a shared library, for callers in other languages (Exhume's tools/bcc20.py)
UNAME := $(shell uname -s)
SHLIB := build/libbcc20$(if $(filter Darwin,$(UNAME)),.dylib,$(if $(findstring MINGW,$(UNAME)),.dll,.so))
$(SHLIB): build/libbcc20.a
	$(CC) -shared -o $@ build/lib/bcc20.o

.PHONY: lib shlib
lib: build/libbcc20.a build/bcc20run
shlib: $(SHLIB)

# replay every translated function against its records (tools/record.py makes them)
.PHONY: check
check: build/replay
	@sh tools/check.sh

.PHONY: clean
clean:
	rm -rf build
