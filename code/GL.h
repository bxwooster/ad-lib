struct GL_Error {
	int valid;
	GLenum source;
	GLenum type;
	GLuint id;
	GLenum severity;
	GLsizei length;
	const GLchar * message;
};
