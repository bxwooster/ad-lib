gens := $(subst .c,.h,$(subst code/,gen/,$(shell find code/*.c)))

.PHONY: all gen gendir

all: gen
gen: $(gens)

gendir:
	@mkdir -p gen

gen/%.h: code/%.c | gendir
	makeheaders -h $< > $@

