PLATFORM =
EXE =
ifeq ($(shell uname),Linux)
	PLATFORM = LINUX
	LINK_FLAGS = -lGL -lGLEW
endif
ifeq ($(shell uname),Darwin)
	PLATFORM = DARWIN
	LINK_FLAGS = -framework OpenGL
endif
ifeq ($(shell uname -o),Msys)
	PLATFORM = WINDOWS
	LINK_FLAGS = \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main \
		-I/usr/local/include \
		-L/usr/local/lib
	EXE = .exe
endif
ifeq ($(PLATFORM),)
	$(error Could not determine platform.)
endif

MAIN = Main$(EXE)

.PHONY: \
  clean run package \
  it a the

$(MAIN): src/*.c
	gcc \
	-Wall \
	-Wextra \
	-std=gnu99 \
	src/*.c \
	-DPLATFORM_$(PLATFORM) \
	$(LINK_FLAGS) \
	-lSDL2 \
	-lSDL2_image \
	-lm \
	-g \
	-o $(MAIN)

it a the:
	@:

clean:
	rm $(MAIN)

run: $(MAIN)
	@./$(MAIN)

package: $(MAIN)
	rm -rf pkg
	mkdir pkg
	cp -r \
		$(MAIN) sys shd settings \
		`which glew32.dll` \
		`which libSDL2-2-0-0.dll` \
		pkg
	tar -cj pkg -f Cosmos.pkg.tar.gz
