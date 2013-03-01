#define __QUOTE(x) #x
#define _QUOTE(x) __QUOTE(x)

#define __INFO__ \
	__FILE__ ":" \
    _QUOTE(__LINE__)

#define OK(what) \
	do { if (! (what)) { \
		logi ("Something went wrong. More info:"); \
	    logi ("! (%s)", #what); \
	    logi ("@ %s", __INFO__); \
		exit (1); \
	} } while (0)

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

