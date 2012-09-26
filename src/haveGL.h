#if defined ANDROID
	#include <GLES2/gl2.h>
#elif defined IOS
    #include <OpenGLES/ES2/gl.h>
#elif defined LINUX || defined MINGW
	#include <GL/glew.h>
#elif defined MAC
	#include <OpenGL/gl.h>
#endif 

