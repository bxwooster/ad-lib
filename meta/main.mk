PLATFORM =
EXE =
ifeq ($(shell uname),Linux)
	PLATFORM = Linux
	LINK_FLAGS = -lGL -lGLEW
endif
ifeq ($(shell uname),Darwin)
	PLATFORM = Darwin
	LINK_FLAGS = -framework OpenGL
endif
ifeq ($(shell uname -o),Msys)
	PLATFORM = Windows
	LINK_FLAGS = \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main
	EXE = .exe
endif
ifeq ($(PLATFORM),)
	$(error Could not determine platform.)
endif

UPPERCASE_PLATFORM = $(shell echo $(PLATFORM) | tr '[a-z]' '[A-Z]')
MAIN = +/$(PLATFORM)/Main$(EXE)

$(shell mkdir -p +/$(PLATFORM))
# what a hack, really

.PHONY: \
  clean run package \
  it a the

$(MAIN): code/*.c code/*.h
	gcc \
	-Wall \
	-Wextra \
	-std=gnu99 \
	code/*.c \
	-DPLATFORM_$(UPPERCASE_PLATFORM) \
	$(LINK_FLAGS) \
	-lSDL2 \
	-lSDL2_image \
	-lm \
	-g \
	-o $(MAIN)

it a the:
	@:

clean:
	rm -rf +

run: $(MAIN)
	@./$(MAIN)

package: $(MAIN)
	rm -rf +/$(PLATFORM)/package
	mkdir +/$(PLATFORM)/package
	cp -r \
		$(MAIN) data \
		`which glew32.dll` \
		`which libSDL2-2-0-0.dll` \
		+/$(PLATFORM)/package
	tar -cj +/$(PLATFORM)/package -f +/$(PLATFORM)/package.tar.bz2
