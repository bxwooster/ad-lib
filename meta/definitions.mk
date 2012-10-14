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
    link_flags := _lGL _lGLEW
    features += glew
    includes += "#include <GL/glew.h>"
  else ifeq ($(shell uname),Darwin)
    platform := darwin
    cc := gcc
    link_flags := _framework OpenGL
    features += gl
    includes += "#include <OpenGL/gl.h>"
  else ifeq ($(shell uname -o),Msys)
    platform := windows
    cc := gcc
    link_flags := \
      -lmingw32 \
      -lopengl32 \
      -lglew32 \
      -lSDL2main
    exe_suffix := .exe
    features += glew
    includes += "\#include <GL/glew.h>"
  else
    $(error Could not determine platform.)
  endif
endif

features += $(platform)
features += $(program)

base_dir := .build
platform_dir := $(base_dir)/$(platform)
output_dir := $(platform_dir)/output
package_dir := $(platform_dir)/package

all_source = $(shell shopt -s nullglob; echo code/*.c code/*/*.c)
all_headers = $(shell shopt -s nullglob; echo code/*.h code/*/*.h)
exe := $(output_dir)/$(program)$(exe_suffix)
source_c := $(output_dir)/$(program).c
source_h := $(output_dir)/$(program).h
source_ext_h := $(output_dir)/$(program).ext.h
package_archive := $(platform_dir)/package.tar.bz2

