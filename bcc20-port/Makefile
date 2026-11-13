# The port of BCC.EXE: build/replay, the harness that checks translated functions against
# calls recorded in Borland's BCC.EXE (README.md).
CC ?= cc
CFLAGS ?= -std=c11 -O2 -g -Wall -Wextra -Werror=implicit-function-declaration
CPPFLAGS += -Iinclude -Ireplay

SRC := $(sort $(wildcard src/*/*.c))
REPLAY := replay/replay.c replay/functions.c
OBJ := $(patsubst %.c,build/obj/%.o,$(SRC) $(REPLAY))

build/replay: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

build/obj/%.o: %.c $(wildcard include/*.h replay/*.h)
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# replay every translated function against its records (tools/record.py makes them)
.PHONY: check
check: build/replay
	@for f in $$(build/replay --list); do \
	  if [ -f records/$$f.rec ]; then build/replay $$f records/$$f.rec || exit 1; \
	  else echo "$$f: no records (python3 tools/record.py $$f)"; exit 1; fi; done

.PHONY: clean
clean:
	rm -rf build
