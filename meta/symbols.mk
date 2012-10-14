.PHONY: all clean run debug package prepare

all: $(main-exe)

package: $(package-archive)

clean:
	rm -rf $(platform-dir)

run: $(main-exe)
	@./$(main-exe)

debug: $(main-exe)
	@gdb $(main-exe)

prepare: $(all-c) $(all-h)

