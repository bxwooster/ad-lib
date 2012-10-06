#include <math.h>
#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>
#include <dirent.h>
#include <string.h>

#include "sys/queue.h"

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

#if defined PLATFORM_ANDROID || defined PLATFORM_IOS
	#include <SDL.h>
#elif \
		defined PLATFORM_LINUX || \
		defined PLATFORM_DARWIN || \
		defined PLATFORM_WINDOWS
	#include <SDL2/SDL.h>
#endif

#include <SDL2/SDL_image.h>
