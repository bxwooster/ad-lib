#include <stdio.h>
#include "w_GL.h"
#include "w_SDL.h"
#include "common.h"
#include "hot.h"
#include "quotes.h"
#include "shader.h"
#include "projection.h"

#define WIDTH 640.0f
#define HEIGHT 640.0f
#define ROTSPEED 128.0f
#define TRANSPEED 2.0f
#define FOV 90.0f
#define NEAR_PLANE 0.001f

int main (int /*argc*/, char * /*argv*/ []) { 
	int error = 0;

	GLuint prog = GL_FALSE;
	GLuint vbo = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	shader_t vss = { GL_VERTEX_SHADER, &vs, &prog };
	shader_t fss = { GL_FRAGMENT_SHADER, &fs, &prog };

	fprintf (stdout, "%s\n\n", randomquote ());

	hot_init ();

	if (SDL_Init (SDL_INIT_VIDEO) == -1) {
		error = __LINE__;
		goto end;
	}

	SDL_WM_SetCaption ("Cosmos", NULL);

	SDL_Surface * const screen = SDL_SetVideoMode ((int) WIDTH, (int) HEIGHT, 32, SDL_OPENGL | SDL_DOUBLEBUF);
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

	if (hot_load(&vss, "shd/draw.vert", (hot_t) loadshader) == NULL) {
		error = __LINE__;
		goto end;
	}
	if (hot_load(&fss, "shd/draw.frag", (hot_t) loadshader) == NULL) {
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
	
	GLuint const attribute_pos = (GLuint) glGetAttribLocation (prog, "pos");
	if (attribute_pos == -1 ) {
		error = __LINE__;
		goto end;
	}

	glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0,	0);
	glEnableVertexAttribArray (attribute_pos);

	GLint const uniform_mvp = glGetUniformLocation (prog, "mvp");
	if (uniform_mvp == -1) {
		error = __LINE__;
		goto end;
	}

	float mproj [16], mview [16], mworld [16];
	float aspect = WIDTH / HEIGHT;
	projectionmatrix (FOV, aspect, NEAR_PLANE, mproj);

	glMatrixMode(GL_MODELVIEW);

	{
		glLoadIdentity ();
		glTranslatef (0.0f, 0.0f, 0.0f);
		glRotatef (0.0f, 1.0f, 1.0f, 0.0f);
	}
	glGetFloatv (GL_MODELVIEW_MATRIX, mview);

	{
		glLoadIdentity ();
		glTranslatef (0.0f, 0.0f, 2.0f);
		glRotatef (0.0f, 1.0f, 0.0f, 0.0f);
	}
	glGetFloatv (GL_MODELVIEW_MATRIX, mworld);

	for (;;) {
		SDL_Event evt;
		if (SDL_PollEvent (&evt)) {
			if (evt.type == SDL_KEYDOWN) {
				SDLKey key = evt.key.keysym.sym;
				if (key == SDLK_ESCAPE) {
					goto end;
				}
			} else if (evt.type == SDL_MOUSEMOTION) {
				float x = evt.motion.xrel / WIDTH;
				float y = -evt.motion.yrel / HEIGHT;

				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_LEFT)) {
					glLoadIdentity();
					glTranslatef (x * TRANSPEED, y * TRANSPEED, 0.0f);
					glMultMatrixf (mview);
					glGetFloatv (GL_MODELVIEW_MATRIX, mview);
				}

				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_RIGHT)) {
					glLoadIdentity();
					glRotatef (x * ROTSPEED, 0.0f, 1.0f, 0.0f);
					glRotatef (y * ROTSPEED, -1.0f, 0.0f, 0.0f);
					glMultMatrixf (mview);
					glGetFloatv (GL_MODELVIEW_MATRIX, mview);
				}
			} else if (evt.type == SDL_QUIT) {
				goto end;
			}
		}

		if (SDL_GetMouseState(NULL, NULL) != 0) {
			SDL_ShowCursor (0);
			SDL_WM_GrabInput (SDL_GRAB_ON);
		} else {
			SDL_ShowCursor (1);
			SDL_WM_GrabInput (SDL_GRAB_OFF);
		}

		hot_check ();
		glUseProgram (prog);

		float matrix [16];
		glLoadMatrixf(mproj);
		glMultMatrixf(mview);
		glMultMatrixf(mworld);
		glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
		glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix);

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
