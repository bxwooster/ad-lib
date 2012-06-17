#include <stdio.h>
#include "w_GL.h"
#include "w_SDL.h"
#include "common.h"
#include "quotes.h"
#include "shader.h"

int main (int /*argc*/, char * /*argv*/ []) { 
	int error = 0;

	GLuint prog = GL_FALSE;
	GLuint vbo = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	shader_t vss = { GL_VERTEX_SHADER, &vs, &prog };
	shader_t fss = { GL_FRAGMENT_SHADER, &fs, &prog };

	fprintf (stdout, "%s\n\n", randomquote ());

	if (SDL_Init (SDL_INIT_VIDEO) == -1) {
		error = __LINE__;
		goto end;
	}

	SDL_WM_SetCaption ("Cosmos", NULL);

	SDL_Surface * const screen = SDL_SetVideoMode (640, 640, 32, SDL_OPENGL | SDL_DOUBLEBUF);
	if (screen == NULL) {
		error = __LINE__;
		goto end;
	}
	
	GLenum const glew_status = glewInit ();
	if (glew_status != GLEW_OK) {
		error = __LINE__;
		goto end;
	}

	prog = glCreateProgram ();

	if (loadshader (&vss, "shd/vs.glsl") != 0) {
		error = __LINE__;
		goto end;
	}
	if (loadshader (&fss, "shd/fs.glsl") != 0) {
		error = __LINE__;
		goto end;
	}
	
	glDeleteShader (vs);
	glDeleteShader (fs);

	GLint code = GL_FALSE;
	glGetProgramiv (prog, GL_LINK_STATUS, &code);

	if (code == GL_FALSE) {
		error = __LINE__;
		goto end;
	}

	GLfloat const tris [] [2] = {
		{ -1.0, -1.0 },
		{  1.0, -1.0 },
		{ -1.0,  1.0 },
		{ -1.0,  1.0 },
		{  1.0, -1.0 },
		{  1.0,  1.0 }
	};
	int const vertices = sizeof (tris) / sizeof (tris [0]);
	
	glGenBuffers (1, &vbo);
	glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);
	
	GLuint const attribute_coord2d = (GLuint) glGetAttribLocation (prog, "coord2d");
	if (attribute_coord2d == -1 ) {
		error = __LINE__;
		goto end;
	}

	glVertexAttribPointer (attribute_coord2d, 2, GL_FLOAT, GL_FALSE, 0,	0);
	glEnableVertexAttribArray (attribute_coord2d);

	for (;;) {
		SDL_Event ev;
		if (SDL_PollEvent (&ev)) {
			switch (ev.type) {
			  default:
				break;

			  case SDL_KEYDOWN:
				switch (ev.key.keysym.sym) {
				  default:
					break;

				  case SDLK_ESCAPE:
					goto end;
				}
				break;

			  case SDL_QUIT:
				goto end;
			}
		}

		glUseProgram (prog);

		glClearColor (0.0, 0.0, 0.0, 0.0);
		glClear (GL_COLOR_BUFFER_BIT);
		glDrawArrays (GL_TRIANGLES, 0, vertices);
 
		SDL_GL_SwapBuffers ();
	}
 
  end:
	glDeleteBuffers (0, &vbo);
	glDeleteProgram (prog);
	SDL_Quit ();

	if (error) {
		fprintf (stderr, "Something went wrong! If anyone asks, reply '%d'.\n", error);
		getchar ();
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}
