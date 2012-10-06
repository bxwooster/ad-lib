int gl_init () {
	GLenum glew = glewInit();
	if (glew != GLEW_OK) {
		logi ("GLEW error: %s.", glewGetErrorString (glew));
		return 1;
	}

	if (!GLEW_VERSION_2_0) {
		logi ("GL2 is not supported.");
		return 2;
	}

	return 0;
}

