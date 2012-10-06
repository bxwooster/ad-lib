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
		float mmodel [4 * 4],
		float mrot [4 * 4],
		float * tosurface,
		float * apparentratio) {
	float phi = (float) ((time / planet->orbit.period) * M_PI * 2.0);

	memcpy (mmodel, planet->orbit.matrix, sizeof (float) * 16);
	mmodel[12] += planet->orbit.major * cosf (phi);
	mmodel[13] += planet->orbit.minor * sinf (phi);

	float first [3];
	vectordiff (&mmodel[12], &mcam[12], first);

	float p = vectorlength (first);
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
	multiplymatrix (mmodel, rotation);

	memcpy (mrot, mmodel, sizeof (float) * 16);
	mrot[12] = mrot[13] = mrot[14] = 0.0f;

	float move [3] = {0.0f, 0.0f, -offset};
	translatematrix (mmodel, move);

	scalematrix (mmodel, apparent);

	*tosurface = p - r;
	*apparentratio = apparent / r;
}

