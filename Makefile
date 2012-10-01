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
	LINK_FLAGS = -lopengl32 -lglew32 -lmingw32 -lSDL2main
	EXE = .exe
endif
ifeq ($(PLATFORM),)
	$(error Could not determine platform.)
endif

MAIN = Main$(EXE)

.PHONY: all clean run package
all: $(MAIN)

$(MAIN): src/*.c
	gcc \
	-Wall \
	-Wextra \
	-std=gnu99 \
	src/*.c \
	-DPLATFORM_$(PLATFORM) \
	$(LINK_FLAGS) \
	-lSDL2 \
	-lm \
	-g \
	-o $(MAIN)

clean:
	rm $(MAIN)

run: $(MAIN)
	./$(MAIN)

package: $(MAIN)
	rm -rf pkg
	mkdir pkg
	cp -r \
		$(MAIN) sys shd settings \
		`which glew32.dll` \
		`which libSDL2-2-0-0.dll` \
		pkg
	tar -cj pkg -f Cosmos.pkg.tar.gz
