all:
	gcc -std=gnu99 src/*.c -DLINUX -lGL -lGLEW -lSDL2 -lm -g -o Cosmos
