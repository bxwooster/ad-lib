GLuint // program
link_it (
        GLuint vs,
        GLuint fs,
        struct GL * gl
) {
    (void) gl;

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
        if (log) {
            glGetShaderInfoLog (shader, size, NULL, log);
            logi ("%s", log);
            free (log);
        } else {
            logi ("No memory to display shader log!");
        }
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
    size_t memsize = all_count * sizeof (char *);

    char const * all_pieces [all_count];
    memcpy (all_pieces + P, pieces, memsize);
    all_pieces[0] =  
#ifdef GLES
        "#version 100\nprecision mediump float;\n" :
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
            logi ("// piece %d:\n%s", i, all_pieces[i]);
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
            struct GL * gl,
            char const * filename,
            char const * typename,
			char const * typecode
) {
    GLuint program = GL_FALSE;
    unsigned maxN = 256;
	char const * sources [maxN]; /* 1k of memory */
	unsigned N = 1; /* first one is used internally */

    /* load initial .glts file */
    const char * at;
    const char * current_file = at = load_file (filename);
	if (current_file == NULL) goto end;

    /* first line must be the following: */
	const char type_string [] = "#pragma type ";
	int count = strlen (type_string);
	if (strncmp (at, type_string, count) != 0) goto end;
	at += count;

    /* check exact type */
	count = strlen (typename);
	if (strncmp (at, typename, count) != 0) goto end;
	at += count;
    char const * base_file = sources[N++] =
        load_it ("mode/glts/", typename, NULL);
    if (base_file == NULL) goto end;

    /* newline */
	if (*at++ != '\n') goto end;

    const char include_str [] = "#pragma include ";
    count = strlen (include_str);

	for (;strncmp (at, include_str, count) == 0;) {
		at += count;
		char const * newline = strchr (at, '\n');
		if (newline == NULL) goto end;

        char const * included_file = sources[N++] =
                      load_it ("data/shade/", at, newline);
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

    program = link_it (vs, fs, gl);

    glDeleteShader (vs);
    glDeleteShader (fs);

	at = NULL; /* no syntax errors */

end:
    if (at != NULL)
        logi ("Syntax error while loading a GLTS: %s:byte-%d",
            filename, (int) (at - current_file));

	for (unsigned n = 1; n < N; ++n) {
        //logi ("Source %u: %s", n, sources[n]);
    	free ((char *) sources[n]);
    }

    return program;        
}
