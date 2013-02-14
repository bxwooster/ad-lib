GLuint // program
load_glts (
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
        load_glts_file ("mode/glts/", typename, NULL);
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
                      load_glts_file ("data/shade/", at, newline);
        if (included_file == NULL) goto end;

		at = newline + 1;
        if (N >= maxN) {
            log_info ("Whoa there, you included more than %u files!", maxN);
            goto end;
        }
	}

    sources[N++] = current_file;
    sources[0] = (char *) typecode;
    /* will need an extra when typecode is actually used */
    /* note the -1's on two lines below */

    GLuint vs = gl_shader_from_source (sources, N, GL_VERTEX_SHADER);
    GLuint fs = gl_shader_from_source (sources, N, GL_FRAGMENT_SHADER);

    if (vs == GL_FALSE || fs == GL_FALSE)
        log_info ("That happened while loading %s just now.", filename);

    program = link_GLprogram (vs, fs, gl);

    glDeleteShader (vs);
    glDeleteShader (fs);

	at = NULL; /* no syntax errors */

end:
    if (at != NULL)
        log_info ("Syntax error while loading a GLTS: %s:byte-%d",
            filename, (int) (at - current_file));

	for (unsigned n = 1; n < N; ++n) {
        //log_debug ("Source %u: %s", n, sources[n]);
    	free ((char *) sources[n]);
    }

    return program;        
}

