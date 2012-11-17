#include <vec3.h>
#include <mat4.h>
struct planet {
	float size;
	vec3 colour;
	struct {
		float period;
		float major;
		float minor;
	} year;
    struct {
        vec3 axis;
        float period;
    } day;
};

