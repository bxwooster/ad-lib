#include <string.h> /* memcpy */
#include <wrap/GL.h>
#include <wrap/math.h>
#include <stdio.h>
#include "planet.h"
#include "vector.h"

void planetmatrix (
		struct planet const * planet,
		double time,
		float const mcam [4 * 4],
		float matrix [4 * 4]) {
	float phi = (float) ((time / planet->orbit.period) * M_PI * 2.0);

	glLoadMatrixf (planet->orbit.matrix);
	glTranslatef (planet->orbit.major * cosf (phi), planet->orbit.minor * sinf (phi), 0.0f);
	glGetFloatv (GL_MODELVIEW_MATRIX, matrix);

	float first [3];
	vectordiff (&matrix[12], &mcam[12], first);

	float p = vectorlen (first);
	float r = planet->size;
	float apparent = sqrtf (p * p - r * r) * r / p;
	float offset = (r * r) / p;

	float unitx [3] = {1.0f, 0.0f, 0.0f};
	float unity [3] = {0.0f, 1.0f, 0.0f};

	float second [3];
	float third  [3];

	if (first[0] < first[1]) {
		vectorproduct (first, unitx, second);
	} else {
		vectorproduct (first, unity, second);
	}
	vectorproduct (first, second, third);

	vectornorm (first);
	vectornorm (second);
	vectornorm (third);

	float rotation [4 * 4] = {0};
	memcpy (&rotation[8], first, sizeof (first));
	memcpy (&rotation[0], second, sizeof (second));
	memcpy (&rotation[4], third, sizeof (third));
	rotation[15] = 1.0f;

	glMultMatrixf (rotation);
	glTranslatef (0.0f, 0.0f, -offset);
	glScalef (apparent, apparent, apparent);
	glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
}
