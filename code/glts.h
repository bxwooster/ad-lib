struct glts_planeta {
    GLuint program;
    GLuint Apos2d;
    GLint Umv;
    GLint Umvp;
    GLint Ucolour;
    GLint Uuvscale;
    GLint Utexture;
};

struct glts_cello {
    GLuint program;
    GLuint Apos2d;
    GLint Umvp;
    GLint Ucolour;
    GLint Ucutout_center;
    GLint Ucutout_radius;
    GLint Uradius_min;
    GLint Uradius_max;
};

GLuint // program
glts_load (
            struct GL * gl,
            char const * filename,
            char const * typename,
			char const * typecode
);

struct glts_cello
  glts_load_cello (
            struct GL * gl,
            char const * filename

);

struct glts_planeta
  glts_load_planeta (
            struct GL * gl,
            char const * filename
);
