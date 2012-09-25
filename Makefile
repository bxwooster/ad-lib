all:
	gcc -std=gnu99 src/*.c -DPC -lGLEW -lSDL2 -lm -g -o Cosmos
