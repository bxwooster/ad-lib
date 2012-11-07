#include <vec3.h>
#include <mat4.h>
struct planet {
	float size;
	vec3 color;
	struct orbit {
		mat4 matrix;
		float period;
		float major;
		float minor;
	} orbit;
};

