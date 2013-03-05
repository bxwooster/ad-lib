cmake_minimum_required(VERSION 2.8)
project(cosmos)

set(HEADERS)

set(SOURCES gen/supercosmos.c)

include_directories(".." "../ext/windows/include")

cmake_policy(SET CMP0015 NEW)
link_directories("../ext/windows/lib")

add_executable(cosmos ${SOURCES})

target_link_libraries(cosmos m wsock32 mingw32 lua51 SDL2main SDL2 SDL2_image opengl32 glew32)

set(CMAKE_EXE_LINKER_FLAGS "-Wl,--export-all-symbols")
set(CMAKE_C_FLAGS "-std=c99 -Wall -Wextra -Wno-missing-field-initializers -Wno-missing-braces -g -mno-ms-bitfields -DWINDOWS -DHOTLOCAL -DGLEW")
