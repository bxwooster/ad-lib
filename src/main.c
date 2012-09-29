#include <stdio.h>
#include <assert.h>
#include <dirent.h>
#include "haveGL.h"
#include "haveSDL.h"
#include <math.h>
#include "sys/queue.h"
#include "log.h"
#include "hot.h"
#include "shader.h"
#include "planet.h"
#include "matrix.h"
#include "platform.h"

static float const ROTSPEED = 1.0f;
static float const TRANSPEED = 8.0f;
static float const CORKSPEED = 1.0f;
static float const FOV = 60.0f;
static float const NEAR_PLANE = 0.0001f;

struct sysplanet {
	struct planet planet;
	char * file;
	TAILQ_ENTRY(sysplanet) _;
};

int main (int argc, char * argv []) {
	int error = 0;
	int sdlerror = 0;

	logi ("Revving up.");

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
		sdlerror = 1;
		error = __LINE__;
		goto end;
	}

	SDL_Window * window = SDL_CreateWindow ("Cosmos",
		SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
		WIDTH, HEIGHT, 
		SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);

	if (window == NULL) {
		sdlerror = 1;
		error = __LINE__;
		goto end;
	}

	if (SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 2) != 0 ||
		SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 0) != 0)
	{
		sdlerror = 1;
		error = __LINE__;
		goto end;
	}

	SDL_GLContext context = SDL_GL_CreateContext (window);

	if (context == NULL) {
		sdlerror = 1;
		error = __LINE__;
		goto end;
	}
	
	if (SDL_SetRelativeMouseMode (SDL_TRUE) != 0)
	{
		sdlerror = 1;
		error = __LINE__;
		goto end;
	}

#if defined NEED_GLEW

	GLenum glew = glewInit();
	if (glew != GLEW_OK) {
		logi ("GLEW error: %s.", glewGetErrorString (glew));
		error = __LINE__;
		goto end;
	}

	if (!GLEW_VERSION_2_0) {
		logi ("GL2 is not supported.");
		glew = GLEW_ERROR_NO_GL_VERSION;
		error = __LINE__;
		goto end;
	}

#else

	GLenum const GLEW_OK = 0;
	GLenum glew = GLEW_OK;

#endif

	prog = glCreateProgram ();

	if (hotload (&vss, SHDDIR "/draw.vert", (hot_loader_t) loadshader) == NULL) {
		error = __LINE__;
		goto end;
	}
	if (hotload (&fss, SHDDIR "/draw.frag", (hot_loader_t) loadshader) == NULL) {
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
		{-1.0,-1.0},
		{ 1.0,-1.0},
		{-1.0, 1.0},
		{-1.0, 1.0},
		{ 1.0,-1.0},
		{ 1.0, 1.0}
	};
	int const vertices = sizeof (tris) / sizeof (tris[0]);
	
	glGenBuffers (1, &vbo);
	glBindBuffer (GL_ARRAY_BUFFER, vbo);
	glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

	glEnable (GL_DEPTH_TEST);
	glViewport (0 ,0, WIDTH, HEIGHT);

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

	float mproj [4 * 4];
	float aspect = ((float) WIDTH) / HEIGHT;
	projectionmatrix (FOV, aspect, NEAR_PLANE, mproj);

	/* rotate one-eighty around Y */
	float mcam [4 * 4] = {
		-1.0f, 0.0f, 0.0f, 0.0f,
		 0.0f, 1.0f, 0.0f, 0.0f,
		 0.0f, 0.0f,-1.0f, 0.0f,
		 0.0f, 0.0f, 0.0f, 1.0f };
	/* note that the order is reversed */
	mcam[14] += 20.0f;

	sysdir = opendir (SYSDIR);
	if (sysdir == NULL) {
		error = __LINE__;
		goto end;
	}

	struct dirent * dirent = NULL;
	while ((dirent = readdir (sysdir)) != NULL) {
#if defined PLATFORM_WINDOWS
		if (dirent->d_name[0] != '.') {
#else
		if (dirent->d_type == DT_REG) {
#endif
			size_t len = strlen (SYSDIR) + 1 + strlen (dirent->d_name) + 1;
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
			logi ("GL error # %d.", glerror);
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
				float x = evt.motion.xrel / ((float) WIDTH);
				float y = evt.motion.yrel / ((float) HEIGHT);

				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_LEFT)) {
					//XXX need to pre-, not post-translate
					mcam[12] += x * TRANSPEED;
					mcam[13] += y * TRANSPEED;
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_RIGHT)) {
					float axis [3];
					axis[0] = -y;
					axis[1] = -x;
					axis[2] = 0.0f;
					float angle = sqrtf (x * x + y * y) * ROTSPEED;
					rotatematrix (mcam, angle, axis);
				} else
				if (evt.motion.state == SDL_BUTTON (SDL_BUTTON_MIDDLE)) {
					float axis [3];
					axis[0] = 0.0f;
					axis[1] = 0.0f;
					axis[2] = 1.0f;
					float angle = -x * CORKSPEED;
					rotatematrix (mcam, angle, axis);
					mcam[14] += y * TRANSPEED;
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
			memcpy (matrix, mproj, sizeof (matrix));
			multiplymatrix (matrix, mview);
			multiplymatrix (matrix, mmodel);

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

	if (glew == GLEW_OK) {
		glDeleteBuffers (1, &vbo);
		glDeleteProgram (prog);
	}

	if (sdlerror != 0) {
		logi ("SDL error: %s.", SDL_GetError ());
	}

	if (context != NULL) {
		SDL_GL_DeleteContext (context);
	}
	SDL_Quit ();

	if (error) {
		logi ("Error # %d.", error);
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}

