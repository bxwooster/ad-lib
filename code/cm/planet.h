struct planet {
	float size;
	float color [3];
	struct orbit {
		mat4 matrix;
		float period;
		float major;
		float minor;
	} orbit;
};

