enum kind {
	KIND_VERTEX = 0,
	KIND_GEOMETRY,
	KIND_FRAGMENT,
	KIND_COMPUTE,
	KIND_COUNT
};

static GLenum gl_kinds [KIND_COUNT] = {
	GL_VERTEX_SHADER,
	GL_GEOMETRY_SHADER,
	GL_FRAGMENT_SHADER,
	GL_COMPUTE_SHADER,
};

static char * kind_defines [KIND_COUNT] = {
	"#define VS\n",
	"#define GS\n",
	"#define FS\n",
	"#define CS\n",
};

static void glts_program_log (GLuint program) {
    GLint size = 0;
    glGetProgramiv (program, GL_INFO_LOG_LENGTH, &size);
    char * log;
    if (size > 0) {
        log = malloc (size);
        OK (log);

        glGetProgramInfoLog (program, size, NULL, log);
        logi ("%s", log);

        free (log);
    } else {
        logi ("No program log available.");
    }
}

static void glts_shader_log (GLuint shader) {
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

static GLuint glts_link (GLuint ks [KIND_COUNT]) {
    GLuint program = glCreateProgram ();
	for (int i = 0; i < KIND_COUNT; i++) {
		if (ks [i] != GL_FALSE) {
			glAttachShader (program, ks [i]);
		}
	}

    GLint code = GL_FALSE;
    glLinkProgram (program);
    glGetProgramiv (program, GL_LINK_STATUS, &code);

    if (code == GL_FALSE) {
        logi ("Shader linking failed.");
		glts_program_log (program);
        glDeleteProgram (program);
        return GL_FALSE;
    }

	for (int i = 0; i < KIND_COUNT; i++) {
		if (ks [i] != GL_FALSE) {
			glDetachShader (program, ks [i]);
		}
	}

    return program;
}

static GLuint glts_do_it (char const * pieces [], unsigned count, int kind) {
    GLuint shader = GL_FALSE;
    GLint code = GL_FALSE;
    shader = glCreateShader (gl_kinds [kind]);

    unsigned const P = 2;
    unsigned const all_count = P + count;
    size_t memsize = count * sizeof (char *);

    char const * all_pieces [all_count];
    memcpy (all_pieces + P, pieces, memsize);
    all_pieces[0] =  
#ifdef GLES
        "#version 100\nprecision mediump float;\n";
#else
        "#version 430 core\n";
#endif
    all_pieces[1] = kind_defines [kind];

    glShaderSource (shader, all_count, all_pieces, NULL);
    glCompileShader (shader);
    glGetShaderiv (shader, GL_COMPILE_STATUS, &code);

    if (code == GL_FALSE) {
        logi ("Shader source:\n");
        for (unsigned i = 0; i < all_count; i++)
            logi ("Piece %d:\n%s", i, all_pieces[i]);
        glts_shader_log (shader);
        glDeleteShader (shader);
        shader = GL_FALSE;
    }

    return shader;
}

static char * // contents
glts_get_file (
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

struct GLprog
glts_load (char const * filename, char const * text) {
    GLuint program = GL_FALSE;
    unsigned maxN = 256;
	char const * sources [maxN]; /* 1k of memory */
	unsigned N = 0;

	unsigned kindmask = 1<<KIND_VERTEX | 1<<KIND_FRAGMENT;

    /* load initial .glts file */
    const char * at;
    const char * current_file = at = text;
	if (current_file == NULL) goto end;

    const char kinds_str [] = "#pragma kinds ";
    int count = strlen (kinds_str);

	if (strncmp (at, kinds_str, count) == 0) {
		at += count;
		char const * newline = strchr (at, '\n');
		if (newline == NULL) goto end;

		kindmask = 0;
		unsigned kind;
		for (char const * K = at; K != newline; K++) {
			switch (*K) {
				case 'V': kind = KIND_VERTEX; break;
				case 'G': kind = KIND_GEOMETRY; break;
				case 'F': kind = KIND_FRAGMENT; break;
				case 'C': kind = KIND_COMPUTE; break;
				default:
					logi ("Unknown kind: %c", *K);
					goto end;
			}
			if (kindmask & 1<<kind) {
				logi ("Kind duplication: %c", *K);
				goto end;
			}
			kindmask |= 1<<kind;
		}

		at = newline + 1;
	}

    const char include_str [] = "#pragma include ";
    count = strlen (include_str);

	for (;strncmp (at, include_str, count) == 0;) {
		at += count;
		char const * newline = strchr (at, '\n');
		if (newline == NULL) goto end;

        char const * included_file = sources[N++] =
                      glts_get_file ("glsl/", at, newline);
        if (included_file == NULL) goto end;

		at = newline + 1;
        if (N >= maxN) {
            logi ("Whoa there, you included more than %u files!", maxN);
            goto end;
        }
	}

    sources[N++] = current_file;

	GLuint ks [KIND_COUNT];
	for (int i = 0; i < KIND_COUNT; ++i) {
		if (kindmask & 1<<i) {
			ks [i] = glts_do_it (sources, N, i);
		} else
			ks [i] = GL_FALSE;
	}

    program = glts_link (ks);
	if (program == GL_FALSE) {
		logi ("That happened while loading %s just now. Kindmask is %d",
				filename, kindmask);
	}

	for (int i = 0; i < KIND_COUNT; ++i) {
		if (ks [i] != GL_FALSE)
			glDeleteShader (ks [i]);
	}

	at = NULL; /* no syntax errors */

end:
    if (at != NULL)
        logi ("Syntax error while loading a GLTS: %s:byte-%d",
            filename, (int) (at - current_file));

	for (unsigned n = 0; n < N - 1; ++n) {
    	free ((char *) sources[n]);
    }

    return (struct GLprog) {program};
}
