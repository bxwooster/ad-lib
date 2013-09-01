static struct GL_Error gl_error;

void DebugCallbackARB (
		GLenum source,
		GLenum type,
		GLuint id,
		GLenum severity,
		GLsizei length,
		const GLchar * message,
		GLvoid * userParam
) {
	(void) userParam;

	//logi ("GL Error: %s", message);
	gl_error.valid = 1;
	gl_error.source = source;
	gl_error.type = type;
	gl_error.id = id;
	gl_error.severity = severity;
	gl_error.length = length;

	free ((void *) gl_error.message);
	gl_error.message = strdup (message);
	OK (gl_error.message);
}

struct GL_Error * GLError (void) {
	return &gl_error;
}
