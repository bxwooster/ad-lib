#include <stdio.h>
#include <assert.h>
#include <dirent.h>
#include <GL/glew.h>
#include <SDL2/SDL.h>
#include <math.h>
#include "sys/queue.h"
#include "hot.h"
#include "shader.h"
#include "planet.h"
#include "matrix.h"

static float const WIDTH = 960.0f;
static float const HEIGHT = 960.0f;
static float const ROTSPEED = 128.0f;
static float const TRANSPEED = 2.0f;
static float const CORKSPEED = 16.0f;
static float const FOV = 60.0f;
static float const NEAR_PLANE = 0.0001f;
static const char * const SYSDIR = "sys";

struct sysplanet {
	struct planet planet;
	char * file;
	TAILQ_ENTRY(sysplanet) _;
};

int main (int argc, char * argv []) {
	int error = 0;

	GLuint prog = GL_FALSE;
	GLuint vbo = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	DIR * sysdir = NULL;

	TAILQ_HEAD (head, sysplanet) list;
	TAILQ_INIT (&list);

	struct shader_t vss = {GL_VERTEX_SHADER, &vs, &prog};
	struct shader_t fss = {GL_FRAGMENT_SHADER, &fs, &prog};

	hotinit ();

	if (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) < 0) {
		error = __LINE__;
		goto end;
	}

	SDL_Window * window = SDL_CreateWindow ("Cosmos",
		SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
		(int) WIDTH, (int) HEIGHT,
		SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);

	if (window == NULL) {
		error = __LINE__;
		goto end;
	}

	SDL_GLContext context = SDL_GL_CreateContext (window);

	if (context == 0) {
		error = __LINE__;
		goto end;
	}

	if (glewInit () != GLEW_OK) {
		printf ("GLEW error: %s\n", glewGetString(glewInit ()));
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
	glTranslatef (0.0f, 0.0f, -20.0f);
	glGetFloatv (GL_MODELVIEW_MATRIX, mcam);

	sysdir = opendir (SYSDIR);
	if (sysdir == NULL) {
		error = __LINE__;
		goto end;
	}

	struct dirent * dirent = NULL;
	while ((dirent = readdir (sysdir)) != NULL) {
		if (dirent->d_type == DT_REG) {
			size_t len = strlen (SYSDIR) + 1 + strlen(dirent->d_name) + 1;
			struct sysplanet * item = (struct sysplanet *) malloc (sizeof (*item));
			assert (item != NULL);
			item->file = (char *) malloc (len);
			assert (item->file != NULL);
			
			snprintf (item->file, len, "%s/%s", SYSDIR, dirent->d_name);
			TAILQ_INSERT_TAIL (&list, item, _);

			if (hotload (&item->planet, item->file, (hot_loader_t) loadplanet) == NULL) {
				error = __LINE__;
				goto end;
			}
		}
	}

	for (;;) {
		GLuint glerror = glGetError ();
		if (glerror != 0) {
			error = __LINE__;
			goto end;
		}

		SDL_Event evt;
		if (SDL_PollEvent (&evt)) {
			if (evt.type == SDL_KEYDOWN) {
				SDL_Keycode key = evt.key.keysym.sym;
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
			SDL_SetWindowGrab (window, SDL_TRUE);
		} else {
			SDL_ShowCursor (1);
			SDL_SetWindowGrab (window, SDL_FALSE);
		}

		hotcheck ();
		glUseProgram (prog);

		double time = (double) SDL_GetTicks () / 1000;

		glClearColor (0.0, 0.0, 0.0, 0.0);
		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		float mview [4 * 4];
		memcpy (mview, mcam, sizeof (mview));
		invertspecialmatrix (mview);

		struct sysplanet * item;
		TAILQ_FOREACH(item, &list, _) {
			float mmodel [4 * 4];
			planetmatrix (&item->planet, time, mcam, mmodel);

			float matrix [4 * 4];
			glLoadMatrixf (mproj);
			glMultMatrixf (mview);
			glMultMatrixf (mmodel);
			glGetFloatv (GL_MODELVIEW_MATRIX, matrix);
			glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix);
			glUniform3fv (uniform_color, 1, (float const *) item->planet.color);

			glDrawArrays (GL_TRIANGLES, 0, vertices);
		}
 
		SDL_GL_SwapWindow (window);
	}
 
  end:

	hotfin ();

	struct sysplanet * item;
	struct sysplanet * tvar;

	TAILQ_FOREACH_SAFE(item, &list, _, tvar) {
		free ((void *) item->file);
		TAILQ_REMOVE (&list, item, _);
		free ((void *) item);
	}

	if (sysdir != NULL) {
		closedir (sysdir);
	}

	glDeleteBuffers (1, &vbo);
	glDeleteProgram (prog);
	SDL_GL_DeleteContext (context);
	SDL_Quit ();

	if (error) {
		fprintf (stderr, "Something went wrong! "
			"If anyone asks, reply '%d'.\n"
			"Press the 'Any' key to exit.\n", error);
		getchar ();
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}

