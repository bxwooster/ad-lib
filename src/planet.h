struct planet {
	float size;
	float color [3];
	struct orbit {
		float matrix [4 * 4];
		float period;
		float major;
		float minor;
	} orbit;
};

int loadplanet (struct planet * planet, char const * file);

void planetmatrix(
	struct planet const * planet,
	double time,
	float const mview [4 * 4],
	float matrix [4 * 4]);

