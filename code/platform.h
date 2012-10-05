#if defined PLATFORM_ANDROID

#define SYSDIR "/sdcard/cosmos/sys"
#define SHDDIR "/sdcard/cosmos/shd"
#define GL_SHADER_PREFIX "#version 100\nprecision mediump float;\n"

#elif defined PLATFORM_IOS

#define SYSDIR "sys"
#define SHDDIR "shd"
#define GL_SHADER_PREFIX "#version 100\nprecision mediump float;\n"

#elif defined PLATFORM_LINUX || defined PLATFORM_DARWIN || defined PLATFORM_WINDOWS

#define SYSDIR "data/spawn"
#define SHDDIR "data/shade"
#define GL_SHADER_PREFIX "#version 120\n"

#endif

