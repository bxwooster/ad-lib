program ?= cosmos
profile ?= develop
platform ?= native

files :=
features :=

defines :=
includes :=
link_flags :=

all_source :=
all_headers :=

################################################################################

ifeq ($(program),cosmos)

    files += \
             misc \
             vecmat \
             libs \
             glts \
             galaxy \
             stone \
             socket \
             hot \

    features += \
                SDLGL \

	defines += HOTLOCAL

else ifeq ($(program),nadal)

    files += \
             misc \
             socket \
             hot \

else ifeq ($(program),federer)

    files += \
             misc \
             socket \
             hot \

else ifeq ($(program),lunar)

    files += \
             misc \

    features += \
                lua \

else ifeq ($(program),watch)

    files += \
             misc \

endif

################################################################################

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

PLATFORM := $(shell echo $(platform) | tr a-z A-Z) 

################################################################################

defines += $(PLATFORM)
includes += \
			math.h \
			float.h \
			stdio.h \
			errno.h \
			assert.h \
			stdlib.h \
			stdarg.h \
			assert.h \
			dirent.h \
			string.h \
			unistd.h \

link_flags += -lm

ifeq ($(platform),windows)
    exe_suffix := .exe
	includes += malloc.h
endif

ifeq ($(program),watch)
    ifeq ($(platform),windows)
        includes += windows.h
    endif
endif

ifneq ($(filter socket,$(files)),)
    ifeq ($(platform),windows)
        link_flags += -lwsock32
        includes += winsock.h
    else
	    includes += \
					sys/socket.h \
					netinet/in.h \
					arpa/inet.h \

    endif
    ifeq ($(platform),linux)
		defines += _GNU_SOURCE # ip_mreq needs it
    endif
endif

ifeq ($(platform),windows)
    link_flags += -lmingw32
endif

ifneq ($(filter lua,$(features)),)
    includes += lauxlib.h lua.h lualib.h
    ifeq ($(platform),windows)
        link_flags += -llua51
    endif
endif

ifneq ($(filter SDLGL,$(features)),)
    ifeq ($(platform),windows)
        link_flags += -lSDL2main
    endif
    # order is important here

    link_flags += -lSDL2
    link_flags += -lSDL2_image
    includes += SDL2/SDL.h SDL2/SDL_image.h

    ifeq ($(platform),ios)
        includes += OpenGLES/ES2/gl.h OpenGLES/ES2/glext.h
        defines += GLES
    else ifeq ($(platform),android)
        includes += GLES2/gl2.h
        defines += GLES
    else ifeq ($(platform),linux)
        includes += GL/glew.h
        defines += GLEW
        link_flags += -lGL -lGLEW
    else ifeq ($(platform),windows)
        includes += GL/glew.h
        defines += GLEW
        link_flags += -lopengl32 -lglew32
    else ifeq ($(platform),darwin)
        link_flags += -framework OpenGL
        includes += OpenGL/gl.h
    endif
endif

ifeq ($(profile),develop)
    optimization := -g
else ifeq ($(profile),release)
    optimization := -Os -Werror
endif

all_source += code/$(program).c
all_source += $(addprefix code/,$(addsuffix .c,$(files)))
all_headers += $(addprefix code/,$(addsuffix .h,$(files)))

prefixed_defines := $(addprefix -D,$(defines))

base_dir := .build
platform_dir := $(base_dir)/$(platform)
output_dir := $(platform_dir)/output
package_dir := $(platform_dir)/package
config_dir := .config/$(platform)
config_include_dir := $(config_dir)/include
config_lib_dir := $(config_dir)/lib

exe := $(output_dir)/$(program)$(exe_suffix)
package_archive := $(platform_dir)/package.tar.bz2

include_flags := $(addprefix -include ,$(includes) $(all_headers))

cc := gcc
cflags := -std=c99 \
	-Wall \
	-Wextra \
	-Wno-missing-field-initializers \
	-Wno-missing-braces \
	-I$(config_include_dir) \
	-L$(config_lib_dir) \
	$(include_flags) \
	$(optimization) \
	$(link_flags) \
	$(prefixed_defines) \

################################################################################

.PHONY: all package clean run debug prepare

all: $(exe)

package: $(package_archive)

clean:
	rm -rf $(platform_dir)

run: $(exe)
	@./$(exe)

debug: $(exe)
	@gdb $(exe)

prepare: $(source_c) $(source_h) $(source_ext_h)

################################################################################

SHELL := bash
export

$(exe): code $(all_source) $(all_headers) | $(output_dir)
	@echo "Making the executable..."
	$(cc) -o $(exe) $(all_source) $(cflags)

$(package_archive): $(exe) | $(package_dir)
	@echo "Making '$(package_archive)'..."
	@cp -r $(exe) data mode art $(package_dir)
	@tar -cj $(package_dir) -f $(package_archive)

$(output_dir): | $(platform_dir)
	mkdir $(output_dir)

$(package_dir): | $(platform_dir)
	mkdir $(package_dir)

$(platform_dir): | $(base_dir)
	mkdir $(platform_dir)

$(base_dir):
	mkdir $(base_dir)
