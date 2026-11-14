# The port of BCC.EXE: build/replay, the harness that checks translated functions against
# calls recorded in Borland's BCC.EXE (README.md).
CC ?= cc
CFLAGS ?= -std=c11 -O2 -g -Wall -Wextra -Wno-missing-field-initializers \
          -Werror=implicit-function-declaration
CPPFLAGS += -Iinclude -Ireplay

SRC := $(sort $(wildcard src/*/*.c))
REPLAY := replay/replay.c replay/functions.c
OBJ := $(patsubst %.c,build/obj/%.o,$(SRC) $(REPLAY)) build/obj/adapters.o

build/replay: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# the generated adapters (tools/genadapters.py)
build/adapters.c: tools/genadapters.py tools/record.py $(SRC)
	python3 tools/genadapters.py adapters $@

build/obj/adapters.o: build/adapters.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

build/obj/%.o: %.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# the native build (README.md, "Plan", step 3): the translations with native/ in place of
# the replay harness
NATIVE := $(sort $(wildcard native/*.c))
NATIVE_OBJ := $(patsubst %.c,build/native/%.o,$(SRC) $(NATIVE)) build/native/adapters.o
BCC20_EXE ?= $(abspath ../bcc20/toolchain/BC20/BIN/BCC.EXE)

build/bcc: $(NATIVE_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

build/native/adapters.o: build/adapters.c $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE $(CFLAGS) -c -o $@ $<

build/native/%.o: %.c $(wildcard include/*.h replay/*.h native/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -Inative -DPORT_NATIVE -DBCC20_EXE_DEFAULT='"$(BCC20_EXE)"' $(CFLAGS) -c -o $@ $<

.PHONY: native
native: build/bcc

# replay every translated function against its records (tools/record.py makes them)
.PHONY: check
check: build/replay
	@sh tools/check.sh

.PHONY: clean
clean:
	rm -rf build
