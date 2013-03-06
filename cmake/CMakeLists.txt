cmake_minimum_required(VERSION 2.8)
project(cosmos)

if(NOT DEFINED PLAT)
    message("Native!")
    if(WIN32)
        set(PLAT "windows")
    elseif(APPLE)
        set(PLAT "darwin")
    else()
        set(PLAT "linux")
    endif()
endif(NOT DEFINED PLAT)
if(PLAT STREQUAL "ios")
    set(IOS 1)
elseif(PLAT STREQUAL "linux")
    set(LINUX 1)
elseif(PLAT STREQUAL "darwin")
    set(DARWIN 1)
endif(PLAT STREQUAL "ios")

message("Platform is ${PLAT}!")

set(DIR "${CMAKE_CURRENT_SOURCE_DIR}/..")
include_directories("${DIR}")
include_directories("${DIR}/ext/${PLAT}/include")
include_directories("${DIR}/ext/common/include")
include_directories("/usr/local/include")
cmake_policy(SET CMP0015 NEW)
link_directories("${DIR}/ext/${PLAT}/lib")
if(DARWIN)
link_directories("/usr/local/lib")
endif(DARWIN)

set(SOURCES "${DIR}/gen/supercosmos.c")
if(DEFINED IOS)
    set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.mycompany.\${PRODUCT_NAME:identifier}")
    add_executable(cosmos MACOSX_BUNDLE "${SOURCES}")
else()
    add_executable(cosmos "${SOURCES}")
endif(DEFINED IOS)

if(WIN32)
    target_link_libraries(cosmos wsock32 mingw32 opengl32 glew32 lua51)
    set(CMAKE_EXE_LINKER_FLAGS "-Wl,--export-all-symbols")
elseif(DEFINED DARWIN)
    set(CMAKE_EXE_LINKER_FLAGS "-pagezero_size 10000 -image_base 100000000")
else()
    set(CMAKE_EXE_LINKER_FLAGS "-rdynamic")
endif()

if(DEFINED IOS)
    set(IOS_FRAMEWORKS
        Foundation
        AudioToolbox
        CoreGraphics
        CoreAudio
        ImageIO
        MobileCoreServices
        QuartzCore
        UIKit
        OpenGLES
    )
    foreach(FW ${IOS_FRAMEWORKS})
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
    endforeach()

    set(CMAKE_OSX_ARCHITECTURES "armv7")

    set_target_properties(cosmos PROPERTIES XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")
    set_target_properties(cosmos PROPERTIES XCODE_ATTRIBUTE_DEAD_CODE_STRIPPING NO)
    set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2")
    set(CMAKE_OSX_SYSROOT iphoneos)
    target_link_libraries(cosmos luajit)
elseif(DEFINED DARWIN)
    target_link_libraries(cosmos luajit-5.1)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework OpenGL")
endif(DEFINED IOS)

target_link_libraries(cosmos m SDL2 SDL2_image)
set(CMAKE_C_FLAGS "-g -fvisibility=default -std=c99 -Wall -Wextra -Wno-missing-field-initializers -Wno-missing-braces")

if(WIN32)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mno-ms-bitfields -DWINDOWS -DGLEW")
elseif(DEFINED IOS)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DIOS")
elseif(DEFINED DARWIN)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDARWIN")
elseif(DEFINED LINUX)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLINUX -DGLEW")
endif(WIN32)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHOTREMOTE")
