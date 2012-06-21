#ifndef _INC_MATH
	#define _USE_MATH_DEFINES
	#pragma warning (push)
		#pragma warning (disable : 4738) /* storing 32-bit float result in memory, possible loss of performance */
		#include <math.h>
	#pragma warning (pop)
	#undef _USE_MATH_DEFINES
#endif
