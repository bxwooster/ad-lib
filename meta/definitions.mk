ifeq ($(platform),ios)
  cc := false
  features += gles ios
else ifeq ($(shell uname),Linux)
  cc := gcc
  platform := linux
  link-flags := -lGL -lGLEW
  features += glew linux
else ifeq ($(shell uname),Darwin)
  platform := darwin
  cc := gcc
  link-flags := -framework OpenGL
  features += gl darwin
else ifeq ($(shell uname -o),Msys)
  platform := windows
  cc := gcc
  link-flags := \
    -lmingw32 \
    -lopengl32 \
    -lglew32 \
    -lSDL2main
  exe-suffix := .exe
  features += glew windows
else
  $(error Could not determine platform.)
endif

features += cosmos

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

