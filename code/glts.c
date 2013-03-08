GLuint // program
link_it (
        GLuint vs,
        GLuint fs
) {
    GLuint program = glCreateProgram ();
    glAttachShader (program, vs);
    glAttachShader (program, fs);
    glLinkProgram (program);

    GLint code = GL_FALSE;
    glGetProgramiv (program, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        logi ("Shader linking failed.");
        glDeleteProgram (program);
        return GL_FALSE;
    }

    return program;
}

void log_it (
        GLuint shader
) {
    GLint size = 0;
    glGetShaderiv (shader, GL_INFO_LOG_LENGTH, &size);
    char * log;
    if (size > 0) {
        log = malloc (size);
        OK (log);

        glGetShaderInfoLog (shader, size, NULL, log);
        logi ("%s", log);

        free (log);
    } else {
        logi ("No shader log available.");
    }
}

GLuint
do_it (
        char const * pieces [],
        unsigned count,
        GLenum type
) {
    GLuint shader = GL_FALSE;
    GLint code = GL_FALSE;
    shader = glCreateShader (type);

    unsigned const P = 2;
    unsigned const all_count = P + count;
    size_t memsize = count * sizeof (char *);

    char const * all_pieces [all_count];
    memcpy (all_pieces + P, pieces, memsize);
    all_pieces[0] =  
#ifdef GLES
        "#version 100\nprecision mediump float;\n";
#else
        "#version 120\n";
#endif
    all_pieces[1] = (type == GL_VERTEX_SHADER) ?
        "#define VS\n" : "#define FS\n";

    glShaderSource (shader, all_count, all_pieces, NULL);
    glCompileShader (shader);
    glGetShaderiv (shader, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE) {
        logi ("Shader source:\n");
        for (unsigned i = 0; i < all_count; i++)
            logi ("Piece %d:\n%s", i, all_pieces[i]);
        log_it (shader);
        glDeleteShader (shader);
        shader = GL_FALSE;
    }

    return shader;
}

char * // contents
load_it (
        char const * prefix,
        char const * id_starts,
        char const * id_ends_or_null
) {
    char suffix [] = ".glsl";

    size_t id_size = id_ends_or_null ?
        (size_t) (id_ends_or_null - id_starts) :
        strlen (id_starts);
    size_t size = strlen (prefix) + id_size + sizeof (suffix) + 1;

    char included_file [size];
    snprintf (included_file, size, "%s%.*s%s",
        prefix, (int) id_size, id_starts, suffix);

    return load_file (included_file);
}

GLuint // program
glts_load (
        char * filename,
        char const * text,
        char const * typecode
) {
    GLuint program = GL_FALSE;
    unsigned maxN = 256;
	char const * sources [maxN]; /* 1k of memory */
	unsigned N = 1; /* first one is used internally */

    /* load initial .glts file */
    const char * at;
    const char * current_file = at = text;
	if (current_file == NULL) goto end;

    const char include_str [] = "#pragma include ";
    int count = strlen (include_str);

	for (;strncmp (at, include_str, count) == 0;) {
		at += count;
		char const * newline = strchr (at, '\n');
		if (newline == NULL) goto end;

        char const * included_file = sources[N++] =
                      load_it ("glsl/", at, newline);
        if (included_file == NULL) goto end;

		at = newline + 1;
        if (N >= maxN) {
            logi ("Whoa there, you included more than %u files!", maxN);
            goto end;
        }
	}

    sources[N++] = current_file;
    sources[0] = (char *) typecode;
    /* will need an extra when typecode is actually used */
    /* note the -1's on two lines below */

    GLuint vs = do_it (sources, N, GL_VERTEX_SHADER);
    GLuint fs = do_it (sources, N, GL_FRAGMENT_SHADER);

    if (vs == GL_FALSE || fs == GL_FALSE)
        logi ("That happened while loading %s just now.", filename);

    program = link_it (vs, fs);

    glDeleteShader (vs);
    glDeleteShader (fs);

	at = NULL; /* no syntax errors */

end:
    if (at != NULL)
        logi ("Syntax error while loading a GLTS: %s:byte-%d",
            filename, (int) (at - current_file));

	for (unsigned n = 1; n < N - 1; ++n) {
    	free ((char *) sources[n]);
    }

    return program;        
}

struct glts_cello glts_load_cello (char * filename, char * text) {
    struct glts_cello it;

    it.program = glts_load (filename, text, "");

    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        logi ("GL attribute 'Apos2d' not found");
    }

    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Ucutout_center = glGetUniformLocation (it.program, "Ucutout_center");
    it.Ucutout_radius = glGetUniformLocation (it.program, "Ucutout_radius");
    it.UR1 = glGetUniformLocation (it.program, "UR1");
    it.UR2 = glGetUniformLocation (it.program, "UR2");
    it.Uangle = glGetUniformLocation (it.program, "Uangle");

    return it;
}

struct glts_planeta glts_load_planeta (char * filename, char * text) {
    struct glts_planeta it;

    it.program = glts_load (filename, text, "");

    it.Apos2d = (GLuint) glGetAttribLocation (it.program, "Apos2d");
    if (it.Apos2d == (GLuint) -1) {
        logi ("GL attribute 'Apos2d' not found");
    }

    it.Umv = glGetUniformLocation (it.program, "Umv");
    it.Umvp = glGetUniformLocation (it.program, "Umvp");
    it.Ucolour = glGetUniformLocation (it.program, "Ucolour");
    it.Uuvscale = glGetUniformLocation (it.program, "Uuvscale");
    it.Utexture = glGetUniformLocation (it.program, "Uexture");

    return it;
}
