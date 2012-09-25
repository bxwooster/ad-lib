#if defined ANDROID
	#include <GLES2/gl2.h>
#elif defined LINUX || defined MINGW
	#include <GL/glew.h>
#elif defined MAC
	#include <OpenGL/gl.h>
#endif 

