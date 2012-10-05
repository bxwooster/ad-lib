struct settings {
	float fov;
	unsigned int width;
	unsigned int height;
};

int loadsettings (struct settings * settings, char const * file);

