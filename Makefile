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

.PHONY: all clean
all: $(MAIN)

$(MAIN): src/*.c
	gcc \
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
