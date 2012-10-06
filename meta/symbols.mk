.PHONY: \
	all clean run package \
	it a the

all: $(main-exe)

package: $(package-archive)

clean:
	rm -rf $(platform-dir)

run: $(main-exe)
	@./$(main-exe)

it a the:
	@:

