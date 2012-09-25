#if defined ANDROID

#define SYSDIR "/sdcard/cosmos/sys"
#define SHDDIR "/sdcard/cosmos/shd"
#define GL_SHADER_PREFIX "#version 100\nprecision mediump float;\n"
#define WIDTH 480
#define HEIGHT 724

#elif defined LINUX || defined MAC || defined MINGW

#define SYSDIR "sys"
#define SHDDIR "shd"
#define GL_SHADER_PREFIX "#version 120\n"
#define WIDTH 960
#define HEIGHT 960

#endif

