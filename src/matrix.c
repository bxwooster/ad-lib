#include <wrap/math.h>

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

void invertmatrix(float matrix [4 * 4]) {
	float a = matrix[1];
	float b = matrix[2];
	float c = matrix[6];

	matrix[1] = matrix[4];
	matrix[2] = matrix[8];
	matrix[6] = matrix[9];

	matrix[4] = a;
	matrix[8] = b;
	matrix[9] = c;

	matrix[12] = -matrix[12];
	matrix[13] = -matrix[13];
	matrix[14] = -matrix[14];
}