#include <GL/glew.h>

struct shader_t {
	GLenum type;
	GLuint* shader;
	GLuint* program;
};

int loadshader (struct shader_t * shader, char const * file);