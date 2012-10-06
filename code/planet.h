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

