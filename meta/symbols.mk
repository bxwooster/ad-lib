.PHONY: all clean run package prepare

all: $(main-exe)

package: $(package-archive)

clean:
	rm -rf $(platform-dir)

run: $(main-exe)
	@./$(main-exe)

prepare: $(all-c) $(all-h)

