#include <stdio.h>
#include <wrap/GL.h>
#include <wrap/SDL.h>
#include <wrap/math.h>
#include "hot.h"
#include "quotes.h"
#include "shader.h"
#include "planet.h"
#include "matrix.h"

static float const WIDTH = 640.0f;
static float const HEIGHT = 640.0f;
static float const ROTSPEED = 128.0f;
static float const TRANSPEED = 2.0f;
static float const CORKSPEED = 16.0f;
static float const FOV = 90.0f;
static float const NEAR_PLANE = 0.001f;

int main (int /*argc*/, char * /*argv*/ []) {
	int error = 0;

	GLuint prog = GL_FALSE;
	GLuint vbo = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	shader_t vss = {GL_VERTEX_SHADER, &vs, &prog};
	shader_t fss = {GL_FRAGMENT_SHADER, &fs, &prog};

	fprintf (stdout, "%s\n\n", randomquote ());

	hot_init ();

	if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) == -1) {
		error = __LINE__;
		goto end;
	}

	SDL_WM_SetCaption ("Cosmos", NULL);

	SDL_Surface * const screen = SDL_SetVideoMode (
		(int) WIDTH, (int) HEIGHT, 32,
		SDL_OPENGL | SDL_DOUBLEBUF);

	if (screen == NULL) {
		error = __LINE__;
		goto end;
	}
	
	if (glewInit () != GLEW_OK) {
		error = __LINE__;
		goto end;
	}

	prog = glCreateProgram ();

	if (hot_load (&vss, "shd/draw.vert", (hot_loader_t) loadshader) == NULL) {
		error = __LINE__;
		goto end;
	}
	if (hot_load (&fss, "shd/draw.frag", (hot_loader_t) loadshader) == NULL) {
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

	struct {
		float x;
		float y;
	} const tris [] = {
		{-1.0, -1.0},
		{ 1.0, -1.0},
		{-1.0,  1.0},
		{-1.0,  1.0},
		{ 1.0, -1.0},
		{ 1.0,  1.0}
	};
	int const vertices = sizeof (tris) / sizeof (tris[0]);
	
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

	GLint const uniform_color = glGetUniformLocation (prog, "color");
	if (uniform_mvp == -1) {
		error = __LINE__;
		goto end;
	}

	float mproj  [4 * 4];
	float mview  [4 * 4];
	float aspect = WIDTH / HEIGHT;
	projectionmatrix (FOV, aspect, NEAR_PLANE, mproj);

	glMatrixMode(GL_MODELVIEW);

	glLoadIdentity ();
	glTranslatef (0.0f, 0.0f, 10.0f);
	glRotatef (180.0f, 0.0f, 1.0f, 0.0f);
	glGetFloatv (GL_MODELVIEW_MATRIX, mview);

	struct planet planets [3];
	planets[0].size = 1.0f;
	planets[0].color[0] = 0.4f;
	planets[0].color[1] = 0.7f;
	planets[0].color[2] = 1.0f;
	planets[0].orbit.major = 6.0f;
	planets[0].orbit.minor = 3.0f;
	planets[0].orbit.period = 10.0f;
	glLoadIdentity ();
	glGetFloatv (GL_MODELVIEW_MATRIX, planets[0].orbit.matrix);

	planets[1].size = 0.7f;
	planets[1].color[0] = 1.0f;
	planets[1].color[1] = 0.3f;
	planets[1].color[2] = 0.2f;
	planets[1].orbit.major = 4.0f;
	planets[1].orbit.minor = 4.0f;
	planets[1].orbit.period = 8.0f;
	glLoadIdentity ();
	glGetFloatv (GL_MODELVIEW_MATRIX, planets[1].orbit.matrix);

	planets[2].size = 1.8f;
	planets[2].color[0] = 1.0f;
	planets[2].color[1] = 1.0f;
	planets[2].color[2] = 0.3f;
	planets[2].orbit.major = 7.0f;
	planets[2].orbit.minor = 8.0f;
	planets[2].orbit.period = 17.0f;
	glLoadIdentity ();
	glGetFloatv (GL_MODELVIEW_MATRIX, planets[2].orbit.matrix);

	for (;;) {
		SDL_Event evt;
		if (SDL_PollEvent (&evt)) {
			if (evt.type == SDL_KEYDOWN) {
				SDLKey key = evt.key.keysym.sym;
				if (key == SDLK_ESCAPE) {
					goto end;
				}
			} else if (evt.type == SDL_MOUSEMOTION) {
				float x =  evt.motion.xrel / WIDTH;
				float y = -evt.motion.yrel / HEIGHT;

				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_LEFT)) {
					glLoadIdentity();
					glTranslatef (x * TRANSPEED, y * TRANSPEED, 0.0f);
					glMultMatrixf (mview);
					glGetFloatv (GL_MODELVIEW_MATRIX, mview);
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_RIGHT)) {
					glLoadIdentity();
					glRotatef (sqrtf(x * x + y * y) * ROTSPEED, -y, x, 0.0f);
					glMultMatrixf (mview);
					glGetFloatv (GL_MODELVIEW_MATRIX, mview);
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_MIDDLE)) {
					glLoadIdentity();
					glTranslatef (0.0f, 0.0f, y * TRANSPEED);
					glRotatef (x * CORKSPEED, 0.0f, 0.0f, 1.0f);
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

		double time = (double) SDL_GetTicks () / 1000;

		glClearColor (0.0, 0.0, 0.0, 0.0);
		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		for (int i = 0; i < sizeof (planets) / sizeof (planets[0]); ++i) {
			float mmodel [4 * 4];
			planetmatrix (&planets[i], time, mview, mmodel);

			float matrix [4 * 4];
			glLoadMatrixf(mproj);
			glMultMatrixf(mview);
			glMultMatrixf(mmodel);
			glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
			glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix);
			glUniform3fv (uniform_color, 1, (float const *) &planets[i].color);

			glDrawArrays (GL_TRIANGLES, 0, vertices);
		}
 
		SDL_GL_SwapBuffers ();
	}
 
  end:
	glDeleteBuffers (0, &vbo);
	glDeleteProgram (prog);
	SDL_Quit ();

	if (error) {
		fprintf (stderr, "Something went wrong! "
			"If anyone asks, reply '%d'.\n", error);
		getchar ();
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}
