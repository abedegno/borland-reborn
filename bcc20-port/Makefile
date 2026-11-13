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
build/adapters.c: tools/genadapters.py $(SRC)
	python3 tools/genadapters.py adapters $@

build/obj/adapters.o: build/adapters.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

build/obj/%.o: %.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# replay every translated function against its records (tools/record.py makes them)
.PHONY: check
check: build/replay
	@sh tools/check.sh

.PHONY: clean
clean:
	rm -rf build
