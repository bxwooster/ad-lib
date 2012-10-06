platform :=
link-flags :=
exe-suffix :=
ifeq ($(shell uname),Linux)
	platform := Linux
	link-flags := -lGL -lGLEW
endif
ifeq ($(shell uname),Darwin)
	platform := Darwin
	link-flags := -framework OpenGL
endif
ifeq ($(shell uname -o),Msys)
	platform := Windows
	link-flags := \
		-lmingw32 \
		-lopengl32 \
		-lglew32 \
		-lSDL2main
	exe-suffix := .exe
endif
ifeq ($(platform),)
	$(error Could not determine platform.)
endif
uppercase-platform := $(shell echo $(platform) | tr '[a-z]' '[A-Z]')

platform-dir := _/$(platform)
build-dir := $(platform-dir)/build
package-dir := $(platform-dir)/package

main-exe := $(build-dir)/main$(exe-suffix)
all-c := $(build-dir)/all.c
package-archive := $(platform-dir)/package.tar.bz2

