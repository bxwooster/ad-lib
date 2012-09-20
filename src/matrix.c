#include <math.h>

void identitymatrix (float matrix [4 * 4]) {
	for (int i = 0; i < 4; ++i)
		for (int j = 0; j < 4; ++j)
			matrix[i + 4 * j] = (i == j ? 1.0f : 0.0f);
}

void projectionmatrix (
		float fov,
		float aspect,
		float near,
		float matrix [4 * 4]) {
	float e = 1 / tanf ((float) M_PI / 360.0f * fov);

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

void invertspecialmatrix(float matrix [4 * 4]) {
	float a = matrix[1];
	float b = matrix[2];
	float c = matrix[6];

	matrix[1] = matrix[4];
	matrix[2] = matrix[8];
	matrix[6] = matrix[9];

	matrix[4] = a;
	matrix[8] = b;
	matrix[9] = c;

	float x = -matrix[12];
	float y = -matrix[13];
	float z = -matrix[14];

	matrix[12] = matrix[0] * x + matrix[4] * y + matrix[ 8] * z;
	matrix[13] = matrix[1] * x + matrix[5] * y + matrix[ 9] * z;
	matrix[14] = matrix[2] * x + matrix[6] * y + matrix[10] * z;
}

void multiplymatrix (float matrix [4 * 4], float another [4 * 4]) {
	float * a = matrix;
	float * b = another;
	float c [4 * 4]; /* transposed copy of A */

	for (int i = 0; i < 4; ++i) { /* columns */
		for (int j = 0; j < 4; ++j) { /* rows */
			c[j * 4 + i] = a[i * 4 + j];
		}
	}

	for (int i = 0; i < 4; ++i) { /* columns */
		for (int j = 0; j < 4; ++j) { /* rows */
			float * f = &a[i * 4 + j];
			*f = 0;
			for (int k = 0; k < 4; ++k) {
				*f += c[j * 4 + k] * b[i * 4 + k];
			}
		}
	}
			
}

