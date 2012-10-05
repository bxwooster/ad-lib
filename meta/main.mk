platform =
exe-suffix =
ifeq ($(shell uname),Linux)
	platform = Linux
	link-flags = -lGL -lGLEW
endif
ifeq ($(shell uname),Darwin)
	platform = Darwin
	link-flags = -framework OpenGL
endif
ifeq ($(shell uname -o),Msys)
	platform = Windows
	link-flags = \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main
	exe-suffix = .exe
endif
ifeq ($(platform),)
	$(error Could not determine platform.)
endif

uppercase-platform = $(shell echo $(platform) | tr '[a-z]' '[A-Z]')
main = +/$(platform)/Main$(exe-suffix)

$(shell mkdir -p +/$(platform))
# what a hack, really

.PHONY: \
  clean run package \
  it a the

$(main): code/*.c code/*.h
	gcc \
	-Wall \
	-Wextra \
	-std=gnu99 \
	code/*.c \
	-DPLATFORM_$(uppercase-platform) \
	$(link-flags) \
	-lSDL2 \
	-lSDL2_image \
	-lm \
	-g \
	-o $(main)

it a the:
	@:

clean:
	rm -rf +

run: $(main)
	@./$(main)

package: $(main)
	rm -rf +/$(platform)/package
	mkdir +/$(platform)/package
	cp -r \
		$(main) data \
		`which glew32.dll` \
		`which libSDL2-2-0-0.dll` \
		+/$(platform)/package
	tar -cj +/$(platform)/package -f +/$(platform)/package.tar.bz2

