all:
	gcc -std=gnu99 src/*.c -DPC -lGL -lGLEW -lSDL2 -lm -g -o Cosmos
