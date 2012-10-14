.PHONY: all package clean run debug prepare

all: $(exe)

package: $(package-archive)

clean:
	rm -rf $(platform-dir)

run: $(exe)
	@./$(exe)

debug: $(exe)
	@gdb $(exe)

prepare: $(source-c) $(source-h)

