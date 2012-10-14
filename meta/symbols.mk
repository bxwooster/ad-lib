.PHONY: all package clean run debug prepare

all: $(exe)

package: $(package_archive)

clean:
	rm -rf $(platform_dir)

run: $(exe)
	@./$(exe)

debug: $(exe)
	@gdb $(exe)

prepare: $(source_c) $(source_h)

