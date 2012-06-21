#include <wrap/math.h>
#include "vector.h"

void vectorsum(
		float const a [3],
		float const b [3],
		float out [3]) {
	out[0] = a[0] + b[0];
	out[1] = a[1] + b[1];
	out[2] = a[2] + b[2];
}

void vectordiff(
		float const a [3],
		float const b [3],
		float out [3]) {
	out[0] = a[0] - b[0];
	out[1] = a[1] - b[1];
	out[2] = a[2] - b[2];
}

void vectorscale(float v[3], float scale) {
	v[0] *= scale;
	v[1] *= scale;
	v[2] *= scale;
}

void vectorproduct(
		float const a [3],
		float const b [3],
		float out [3]) {
	out[0] = a[1] * b[2] - a[2] * b[1];
	out[1] = a[2] * b[0] - a[0] * b[2];
	out[2] = a[0] * b[1] - a[1] * b[0];
}

float vectorlen(float const v [3]) {
	return sqrtf (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
}

void vectornorm(float v [3]) {
	float len = vectorlen(v);

	v[0] /= len;
	v[1] /= len;
	v[2] /= len;
}
