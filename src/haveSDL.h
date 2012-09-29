#if defined PLATFORM_ANDROID || defined PLATFORM_IOS
	#include <SDL.h>
#elif \
		defined PLATFORM_LINUX || \
		defined PLATFROM_DARWIN || \
		defined PLATFORM_WINDOWS
	#include <SDL2/SDL.h>
#endif

