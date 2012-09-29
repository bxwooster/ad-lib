#if defined PLATFORM_ANDROID
	#include <GLES2/gl2.h>
#elif defined PLATFORM_IOS
    #include <OpenGLES/ES2/gl.h>
#elif defined PLATFORM_LINUX || defined PLATFORM_WINDOWS
	#include <GL/glew.h>
	#define NEED_GLEW
#elif defined PLATFORM_DARWIN
	#include <OpenGL/gl.h>
#endif 

