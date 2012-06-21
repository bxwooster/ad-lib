#include <string.h> /* memcpy */
#include <wrap/GL.h>
#include <wrap/math.h>
#include "planet.h"
#include "vector.h"

void planetmatrix(
		struct planet const * planet,
		double time,
		float const mview [4 * 4],
		float matrix [4 * 4]) {
	float phi = (float) ((time / planet->orbit.period) * M_PI * 2.0);
	float apparent = planet->size;

	glLoadMatrixf (planet->orbit.matrix);
	glTranslatef (planet->orbit.major * cosf (phi), planet->orbit.minor * sinf (phi), 0.0f);
	glGetFloatv (GL_MODELVIEW_MATRIX, matrix);

	float first [3];
	vectorsum (&matrix[8], &mview[8], first);

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

	glScalef (apparent, apparent, apparent);
	if (time - floor(time) < 0.5) glMultTransposeMatrixf (rotation);
	glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
}
