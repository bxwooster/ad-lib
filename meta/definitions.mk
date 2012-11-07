program ?= cosmos
profile ?= develop
platform ?= native
features ?=

ifeq ($(profile),develop)
  optimization := -g
else ifeq ($(profile),release)
  optimization := -Os
endif

ifeq ($(platform),native)
  ifeq ($(shell uname),Linux)
    platform := linux
  else ifeq ($(shell uname),Darwin)
    platform := darwin
  else ifeq ($(shell uname -o),Msys)
    platform := windows
  else
    $(error Could not determine native platform!)
  endif
endif

ifeq ($(program),cosmos)
  ifeq ($(platform),ios)
    cc := false
    defines += GLES
    includes += OpenGLES/ES2/gl.h
    includes += OpenGLES/ES2/glext.h
  else ifeq ($(platform),android)
    cc := false
    defines += GLES
    includes += GLES2/gl2.h
  else ifeq ($(platform),linux)
    cc := gcc
    defines += GLEW
    link_flags += -lGL -lGLEW
    includes += GL/glew.h
  else ifeq ($(platform),darwin)
    cc := gcc
    link_flags += -framework OpenGL
    includes += OpenGL/gl.h
  else ifeq ($(platform),windows)
    cc := gcc
    link_flags += \
      -lmingw32 \
      -lopengl32 \
      -lglew32 \
      -lSDL2main
    exe_suffix := .exe
    defines += GLEW
    includes += GL/glew.h
  endif
  link_flags += -lm
  link_flags += -lSDL2
  link_flags += -lSDL2_image
endif

base_dir := .build
platform_dir := $(base_dir)/$(platform)
output_dir := $(platform_dir)/output
package_dir := $(platform_dir)/package

all_source = $(shell shopt -s nullglob; echo code/*.c code/*/*.c)
all_headers = $(shell shopt -s nullglob; echo code/*.h code/*/*.h)
exe := $(output_dir)/$(program)$(exe_suffix)
source_c := $(output_dir)/source_of_$(program).c
source_h := $(output_dir)/source_of_$(program).h
source_ext_h := $(output_dir)/$(program).ext.h
package_archive := $(platform_dir)/package.tar.bz2

