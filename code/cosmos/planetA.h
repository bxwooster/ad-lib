#include <vec3.h>
#include <mat4.h>
#include <planet_day.h>
struct planetA {
	float size;
	vec3 colour;
	struct {
		float period;
		float major;
		float minor;
	} year;
    struct planet_day day;
};

