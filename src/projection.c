#include "common.h"
#define _USE_MATH_DEFINES
#include <math.h>

void projectionmatrix (float fov, float aspect, float near, float matrix [4 * 4]) {
	float e = 1 / tanf((float) M_PI / 360.0f * fov);

	matrix[0] = e;
	matrix[1] = 0.0f;
	matrix[2] = 0.0f;
	matrix[3] = 0.0f;

	matrix[4] = 0.0f;
	matrix[5] = e / aspect;
	matrix[6] = 0.0f;
	matrix[7] = 0.0f;
	
	matrix[8] = 0.0f;
	matrix[9] = 0.0f;
	matrix[10] = 1.0f;
	matrix[11] = 1.0f;

	matrix[12] = 0.0f;
	matrix[13] = 0.0f;
	matrix[14] = -2.0f * near;
	matrix[15] = 0.0f;
}