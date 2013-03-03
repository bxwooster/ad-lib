#define API

#define __QUOTE(x) #x
#define _QUOTE(x) __QUOTE(x)

#define __INFO \
	__FILE__ ":" \
    _QUOTE(__LINE__) \

#define __UNIQ \
    __uniq__ ## __LINE__ \

#define OK(what) \
	do { if (! (what)) { \
		logi ("Something went wrong. More info:"); \
	    logi ("! (%s)", #what); \
	    logi ("@ %s", __INFO); \
		exit (1); \
	} } while (0) \

#define OK_ELSE(what) \
    for (int __UNIQ = !!(what) || ( \
		logi ("Something went wrong. More info:"), \
    0); __UNIQ < 1; __UNIQ++, \
	    logi ("! (%s)", #what), \
	    logi ("@ %s", __INFO), \
        exit (1)) \

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

