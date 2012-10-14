.PHONY: all clean run debug package prepare

all: $(exe)

package: $(package-archive)

clean:
	rm -rf $(platform-dir)

run: $(exe)
	@./$(exe)

debug: $(exe)
	@gdb $(exe)

prepare: $(all-c) $(all-h)

