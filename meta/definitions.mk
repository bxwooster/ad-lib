platform :=
link-flags :=
exe-suffix :=
features :=
ifeq ($(shell uname),Linux)
	platform := Linux
	link-flags := -lGL -lGLEW
	features += glew
endif
ifeq ($(shell uname),Darwin)
	platform := Darwin
	link-flags := -framework OpenGL
	features += no-glew
endif
ifeq ($(shell uname -o),Msys)
	platform := Windows
	link-flags := \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main
	exe-suffix := .exe
	features += glew
endif
ifeq ($(platform),)
	$(error Could not determine platform.)
endif
uppercase-platform := $(shell echo $(platform) | tr '[a-z]' '[A-Z]')

base-dir := .build
platform-dir := $(base-dir)/$(platform)
output-dir := $(platform-dir)/output
package-dir := $(platform-dir)/package

main-exe := $(output-dir)/main$(exe-suffix)
all-c := $(output-dir)/all.c
all-h := $(output-dir)/all.h
package-archive := $(platform-dir)/package.tar.bz2

