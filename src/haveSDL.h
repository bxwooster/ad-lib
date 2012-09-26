#if defined ANDROID || defined IOS
    #include <SDL.h>
#elif defined LINUX || defined MAC || defined MINGW
	#include <SDL2/SDL.h>
#endif

