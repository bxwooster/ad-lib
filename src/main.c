#include <stdio.h>
#include <wrap/GL.h>
#include <wrap/SDL.h>
#include <wrap/math.h>
#include "hot.h"
#include "quotes.h"
#include "shader.h"
#include "planet.h"
#include "matrix.h"

static float const WIDTH = 960.0f;
static float const HEIGHT = 960.0f;
static float const ROTSPEED = 128.0f;
static float const TRANSPEED = 2.0f;
static float const CORKSPEED = 16.0f;
static float const FOV = 90.0f;
static float const NEAR_PLANE = 0.0001f;

int main (int /*argc*/, char * /*argv*/ []) {
	int error = 0;

	GLuint prog = GL_FALSE;
	GLuint vbo = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	shader_t vss = {GL_VERTEX_SHADER, &vs, &prog};
	shader_t fss = {GL_FRAGMENT_SHADER, &fs, &prog};

	fprintf (stdout, "%s\n\n", randomquote ());

	hotinit ();

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

	if (hotload (&vss, "shd/draw.vert", (hot_loader_t) loadshader) == NULL) {
		error = __LINE__;
		goto end;
	}
	if (hotload (&fss, "shd/draw.frag", (hot_loader_t) loadshader) == NULL) {
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
	
	glEnable(GL_DEPTH_TEST);

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

	glMatrixMode(GL_MODELVIEW);

	float mproj  [4 * 4];
	float aspect = WIDTH / HEIGHT;
	projectionmatrix (FOV, aspect, NEAR_PLANE, mproj);

	float mcam  [4 * 4];
	glLoadIdentity ();
	glRotatef (180.0f, 0.0f, 1.0f, 0.0f);
	glTranslatef (0.0f, 0.0f, -10.0f);
	glGetFloatv (GL_MODELVIEW_MATRIX, mcam);

	struct planet planets [4];

	planets[0].size = 2.0f;
	planets[0].color[0] = 1.0f;
	planets[0].color[1] = 1.0f;
	planets[0].color[2] = 0.2f;
	planets[0].orbit.major = 0.0f;
	planets[0].orbit.minor = 0.0f;
	planets[0].orbit.period = 1.0f;
	identitymatrix(planets[0].orbit.matrix);

	planets[1].size = 0.7f;
	planets[1].color[0] = 1.0f;
	planets[1].color[1] = 0.3f;
	planets[1].color[2] = 0.2f;
	planets[1].orbit.major = 4.0f;
	planets[1].orbit.minor = 4.0f;
	planets[1].orbit.period = 8.0f;
	identitymatrix(planets[1].orbit.matrix);

	planets[2].size = 0.9f;
	planets[2].color[0] = 0.4f;
	planets[2].color[1] = 0.7f;
	planets[2].color[2] = 1.0f;
	planets[2].orbit.major = 7.0f;
	planets[2].orbit.minor = 3.0f;
	planets[2].orbit.period = 11.0f;
	identitymatrix(planets[2].orbit.matrix);

	planets[3].size = 0.8f;
	planets[3].color[0] = 0.7f;
	planets[3].color[1] = 0.4f;
	planets[3].color[2] = 1.0f;
	planets[3].orbit.major = 3.0f;
	planets[3].orbit.minor = 8.0f;
	planets[3].orbit.period = 10.0f;
	identitymatrix(planets[3].orbit.matrix);

	for (;;) {
		GLuint glerror = glGetError ();
		if (glerror != 0) {
			error = __LINE__;
			goto end;
		}

		SDL_Event evt;
		if (SDL_PollEvent (&evt)) {
			if (evt.type == SDL_KEYDOWN) {
				SDLKey key = evt.key.keysym.sym;
				if (key == SDLK_ESCAPE) {
					goto end;
				}
			} else if (evt.type == SDL_MOUSEMOTION) {
				float x = -evt.motion.xrel / WIDTH;
				float y = evt.motion.yrel / HEIGHT;

				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_LEFT)) {
					glLoadMatrixf (mcam);
					glTranslatef (x * TRANSPEED, y * TRANSPEED, 0.0f);
					glGetFloatv (GL_MODELVIEW_MATRIX, mcam);
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_RIGHT)) {
					glLoadMatrixf (mcam);
					glRotatef (sqrtf(x * x + y * y) * ROTSPEED, y, -x, 0.0f);
					glGetFloatv (GL_MODELVIEW_MATRIX, mcam);
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_MIDDLE)) {
					glLoadMatrixf (mcam);
					glRotatef (-x * CORKSPEED, 0.0f, 0.0f, 1.0f);
					glTranslatef (0.0f, 0.0f, y * TRANSPEED);
					glGetFloatv (GL_MODELVIEW_MATRIX, mcam);
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

		hotcheck ();
		glUseProgram (prog);

		double time = (double) SDL_GetTicks () / 1000;

		glClearColor (0.0, 0.0, 0.0, 0.0);
		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		float mview [4 * 4];
		memcpy (mview, mcam, sizeof (mview));
		invertspecialmatrix (mview);

		for (int i = 0; i < sizeof (planets) / sizeof (planets[0]); ++i) {
			float mmodel [4 * 4];
			planetmatrix (&planets[i], time, mcam, mmodel);

			float matrix [4 * 4];
			glLoadMatrixf (mproj);
			glMultMatrixf (mview);
			glMultMatrixf (mmodel);
			glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
			glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix);
			glUniform3fv (uniform_color, 1, (float const *) planets[i].color);

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
