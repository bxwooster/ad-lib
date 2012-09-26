#if defined ANDROID

#include <android/log.h>
#define LOG_TAG "Cosmos"

static const char * const TAG = "Cosmos";

void logi(char const * fmt, ...) {
	va_list args;
	va_start (args, fmt);
	__android_log_vprint (ANDROID_LOG_INFO, TAG, fmt, args);
	va_end (args);
}

#elif defined LINUX || defined MAC || defined MINGW || defined IOS

#include <stdarg.h>
#include <stdio.h>

void logi(char const * fmt, ...) {
	va_list args;
	va_start (args, fmt);
	vfprintf (stdout, fmt, args);
	fprintf (stdout, "\n");
	va_end (args);
}

#endif
