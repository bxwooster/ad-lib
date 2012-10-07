ifeq ($(platform),ios)
	cc := false
	features += no-glew gles ios
else ifeq ($(shell uname),Linux)
	cc := gcc
	platform := linux
	link-flags := -lGL -lGLEW
	features += glew gl
else ifeq ($(shell uname),Darwin)
	cc := gcc
	platform := darwin
	link-flags := -framework OpenGL
	features += no-glew gl darwin
else ifeq ($(shell uname -o),Msys)
	cc := gcc
	platform := windows
	link-flags := \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main
	exe-suffix := .exe
	features += glew gl
else
	$(error Could not determine platform.)
endif
uppercase-platform := $(shell echo $(platform) | tr '[a-z]' '[A-Z]')

base-dir := .build
platform-dir := $(base-dir)/$(platform)
output-dir := $(platform-dir)/output
package-dir := $(platform-dir)/package

all-source = $(shell shopt -s nullglob; echo code/*.c code/*/*.c)
all-headers = $(shell shopt -s nullglob; echo code/*.h code/*/*.h)
main-exe := $(output-dir)/main$(exe-suffix)
all-c := $(output-dir)/all.c
all-h := $(output-dir)/all.h
package-archive := $(platform-dir)/package.tar.bz2

