#include <string.h> /* memcpy */
#include <math.h>
#include <stdio.h>
#include "planet.h"
#include "vector.h"
#include "matrix.h"

int loadplanet (struct planet * planet, char const * file) {
	int error = 0;
	FILE * fp = NULL;
	struct planet read;

	if ((fp = fopen (file, "rb")) == 0 ||
		fscanf (fp, "size: %f", &read.size) != 1 ||
		fscanf (fp, "\ncolor: %f, %f, %f",
			read.color,
			read.color + 1,
			read.color + 2) != 3 ||
		fscanf (fp, "\nmajor: %f", &read.orbit.major) != 1 ||
		fscanf (fp, "\nminor: %f", &read.orbit.minor) != 1 ||
		fscanf (fp, "\nperiod: %f", &read.orbit.period) != 1
	) {
		error = __LINE__;
		goto end;
	}

	fscanf (fp, "\n");
	if (fgetc (fp) != EOF) {
		error = __LINE__;
		goto end;
	}

	identitymatrix (read.orbit.matrix);

	*planet = read;

	end:

	if (fp != NULL) {
		fclose (fp);
	}

	return (error);
}

void planetmatrix (
		struct planet const * planet,
		double time,
		float const mcam [4 * 4],
		float matrix [4 * 4]) {
	float phi = (float) ((time / planet->orbit.period) * M_PI * 2.0);

	memcpy (matrix, planet->orbit.matrix, sizeof (float) * 16);
	matrix[12] += planet->orbit.major * cosf (phi);
	matrix[13] += planet->orbit.minor * sinf (phi);

	float first [3];
	vectordiff (&matrix[12], &mcam[12], first);

	float p = vectorlen (first);
	float r = planet->size;
	float apparent = sqrtf (p * p - r * r) * r / p;
	float offset = (r * r) / p;

	float unitx [3] = {1.0f, 0.0f, 0.0f};
	float unity [3] = {0.0f, 1.0f, 0.0f};

	float second [3];
	float third [3];

	if (first[0] < first[1]) {
		vectorproduct (first, unitx, second);
	} else {
		vectorproduct (first, unity, second);
	}
	vectorproduct (first, second, third);

	vectornormalize (first);
	vectornormalize (second);
	vectornormalize (third);

	float rotation [4 * 4] = {0};
	memcpy (&rotation[8], first, sizeof (first));
	memcpy (&rotation[0], second, sizeof (second));
	memcpy (&rotation[4], third, sizeof (third));
	rotation[15] = 1.0f;

	multiplymatrix (matrix, rotation);
	matrix[14] -= offset;
	scalematrix (matrix, apparent);
}

