program := cosmos

ifeq ($(program),cosmos)
  ifeq ($(platform),ios)
    cc := false
    features += gles
    includes += "#include <OpenGLES/ES2/gl.h>"
    includes += "#include <OpenGLES/ES2/glext.h>"
  else ifeq ($(platform),android)
    cc := false
    features += gles
    includes += "#include <GLES2/gl2.h>"
  else ifeq ($(shell uname),Linux)
    cc := gcc
    platform := linux
    link-flags := -lGL -lGLEW
    features += glew
    includes += "#include <GL/glew.h>"
  else ifeq ($(shell uname),Darwin)
    platform := darwin
    cc := gcc
    link-flags := -framework OpenGL
    features += gl
    includes += "#include <OpenGL/gl.h>"
  else ifeq ($(shell uname -o),Msys)
    platform := windows
    cc := gcc
    link-flags := \
      -lmingw32 \
      -lopengl32 \
      -lglew32 \
      -lSDL2main
    exe-suffix := .exe
    features += glew
    includes += "\#include <GL/glew.h>"
  else
    $(error Could not determine platform.)
  endif
endif

features += $(platform)
features += $(program)

base-dir := .build
platform-dir := $(base-dir)/$(platform)
output-dir := $(platform-dir)/output
package-dir := $(platform-dir)/package

all-source = $(shell shopt -s nullglob; echo code/*.c code/*/*.c)
all-headers = $(shell shopt -s nullglob; echo code/*.h code/*/*.h)
exe := $(output-dir)/$(program)$(exe-suffix)
source-c := $(output-dir)/$(program).c
source-h := $(output-dir)/$(program).h
source-ext-h := $(output-dir)/$(program).ext.h
package-archive := $(platform-dir)/package.tar.bz2

