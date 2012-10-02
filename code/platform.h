#if defined PLATFORM_ANDROID

#define SYSDIR "/sdcard/cosmos/sys"
#define SHDDIR "/sdcard/cosmos/shd"
#define GL_SHADER_PREFIX "#version 100\nprecision mediump float;\n"
#define WIDTH 480
#define HEIGHT 724

#elif defined PLATFORM_IOS

#define SYSDIR "sys"
#define SHDDIR "shd"
#define GL_SHADER_PREFIX "#version 100\nprecision mediump float;\n"
#define WIDTH 768
#define HEIGHT 1024

#elif defined PLATFORM_LINUX || defined PLATFORM_DARWIN || defined PLATFORM_WINDOWS

#define SYSDIR "data/spawn"
#define SHDDIR "data/shade"
#define GL_SHADER_PREFIX "#version 120\n"
#define WIDTH 960
#define HEIGHT 960

#endif

