program ?= cosmos
profile ?= develop
platform ?= native

ifeq ($(profile),develop)
  optimization := -g
else ifeq ($(profile),release)
  optimization := -Os -Werror
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

cc := gcc
features := $(program)
defines := $(shell echo $(platform) | tr a-z A-Z)
includes :=
link_flags :=

all_source := \
		code/log.c \
		code/sockets.c \

all_headers	:= \
		code/log.h \
		code/sockets.h \

ifeq ($(platform),windows)
	link_flags += lwsock32 # sandbox
endif

ifeq ($(program),cosmos)
	all_source += \
		code/vecmat.c \

	all_headers += \
		code/ext.h \
		code/vecmat.h \
		code/structures.h \
		code/konstants.h \
		code/cosmos.h \

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
    defines += GLEW
    link_flags += -lGL -lGLEW
    includes += GL/glew.h
  else ifeq ($(platform),darwin)
    link_flags += -framework OpenGL
    includes += OpenGL/gl.h
  else ifeq ($(platform),windows)
    link_flags += \
      -lmingw32 \
      -lopengl32 \
      -lglew32 \
      -lSDL2main \

    exe_suffix := .exe
    defines += GLEW
    includes += GL/glew.h
  endif
  link_flags += -lm
  link_flags += -lSDL2
  link_flags += -lSDL2_image
endif

prefixed_defines := $(addprefix -D,$(defines))
base_dir := .build
platform_dir := $(base_dir)/$(platform)
output_dir := $(platform_dir)/output
package_dir := $(platform_dir)/package

all_source += code/$(program).c
all_headers += code/$(program).h
exe := $(output_dir)/$(program)$(exe_suffix)
package_archive := $(platform_dir)/package.tar.bz2

include_flags := $(addprefix -include ,$(includes) $(all_headers))
