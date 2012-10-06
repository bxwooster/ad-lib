void logshader (GLuint sh)
{
	GLint size = 0;
	glGetShaderiv (sh, GL_INFO_LOG_LENGTH, &size);
	assert (size > 0);

	char * log = (char *) malloc ((size_t) size);
	assert (log != NULL);

	glGetShaderInfoLog (sh, size, NULL, log);
	fprintf (stderr, "%s\n", log);
	free (log);
}

int loadshader (struct shader_t * info, char const * file) {
	int error = 0;
	long size;
	FILE * fp = NULL;
	char * src = NULL;
	GLuint sh = GL_FALSE;

	if (
		(fp = fopen (file, "rb")) == 0 ||
		fseek (fp, 0L, SEEK_END) != 0 ||
		(size = ftell (fp)) < 0 ||
		fseek (fp, 0L, SEEK_SET) != 0 ||
		(src = (char *) malloc ((size_t) size + 1)) == NULL ||
		fread(src, 1, (size_t) size, fp) != (size_t) size
	) {
		error = __LINE__;
		goto end;
	}

	src[size] = '\0';

	GLint code = GL_FALSE;
	sh = glCreateShader (info->type);
	
	char const * srcs [] = {gl_shader_prefix (), src};
	glShaderSource (sh, 2, srcs, NULL);
	glCompileShader (sh);
	glGetShaderiv (sh, GL_COMPILE_STATUS, &code);

	if (code == GL_FALSE) {
		logshader (sh);
		error = __LINE__;
		goto end;
	}

	if (info->program != NULL) {
		GLint count = 0;
		glGetProgramiv (*info->program, GL_ATTACHED_SHADERS, &count);

		GLuint * all = (GLuint *) malloc (count * sizeof (*all));
		assert (all != NULL);
		glGetAttachedShaders (*info->program, count, NULL, all);

		GLuint prog = glCreateProgram ();

		for (int i = 0; i < count; ++i) {
			if (all [i] != *info->shader) {
				glAttachShader (prog, all [i]);
			}
		}
		glAttachShader (prog, sh);

		glLinkProgram (prog);
		glGetProgramiv (prog, GL_LINK_STATUS, &code);

		if (code == GL_FALSE) {
			glGetProgramiv (*info->program, GL_LINK_STATUS, &code);
			if (code != GL_FALSE) {
				error = __LINE__;
				goto end;
			}
		}

		glDeleteProgram (*info->program);
		*info->program = prog;
	}

	glDeleteShader (*info->shader);
	*info->shader = sh;
	sh = GL_FALSE;

	end:
	if (sh != GL_FALSE) {
		glDeleteShader (sh);
	}
	if (fp != NULL) {
		fclose (fp);
	}
	free (src);

	return (error);
}

