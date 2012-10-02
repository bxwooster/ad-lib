#include <stdio.h>
#include <assert.h>
#include <dirent.h>
#include "haveGL.h"
#include "haveSDL.h"
#include <SDL2/SDL_image.h>
#include <math.h>
#include <float.h>
#include "sys/queue.h"
#include "log.h"
#include "hot.h"
#include "shader.h"
#include "planet.h"
#include "matrix.h"
#include "platform.h"
#include "settings.h"

static float const ROTATION_SPEED = 1.0f;
static float const TRANSLATION_SPEED = 8.0f;

struct sysplanet {
	struct planet planet;
	char * file;
	TAILQ_ENTRY(sysplanet) _;
};

int main (int argc, char * argv []) {
	(void) argc;
	(void) argv; /* silence warnings */

	int error = 0;
	int sdlerror = 0;

	logi ("Revving up.");

	GLuint prog = GL_FALSE;
	GLuint vs = GL_FALSE;
	GLuint fs = GL_FALSE;

	DIR * sysdir = NULL;

	TAILQ_HEAD (head, sysplanet) list;
	TAILQ_INIT (&list);

	struct shader_t vss = {GL_VERTEX_SHADER, &vs, &prog};
	struct shader_t fss = {GL_FRAGMENT_SHADER, &fs, &prog};

	hotinit ();

	struct settings settings;
	if (loadsettings(&settings, "settings")) {
		error = __LINE__;
		goto end;
	}

	int img_require = IMG_INIT_JPG;
	int img_initted = IMG_Init (img_require);

	if ((img_require & img_initted) != img_require) {
		logi ("SDL_image error: %s", IMG_GetError ());
		error = __LINE__;
		goto end;
	}

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

	glUseProgram (prog);

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
	
	GLuint vbo = GL_FALSE;
	glGenBuffers (1, &vbo);
	glBindBuffer (GL_ARRAY_BUFFER, vbo);
	glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

	GLubyte pixels[6][3] = {
		{255, 0, 0},
		{255, 0, 255},
		{0, 255, 255},
		{0, 0, 255},
		{255, 255, 0},
		{0, 255, 0}, 
	};

	GLuint tex = GL_FALSE;
	glGenTextures (1, &tex);
	glBindTexture (GL_TEXTURE_CUBE_MAP, tex);

	GLenum targets [6] = {
		GL_TEXTURE_CUBE_MAP_POSITIVE_X,
		GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
		GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
		GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
		GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
		GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
	};

	for (int i = 0; i < 6; ++i) {
		glTexImage2D
		(targets[i], 0, GL_RGB, 1, 1, 0, GL_RGB, GL_UNSIGNED_BYTE, pixels[i]);
	}

	glTexParameteri
		(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);

	glTexParameteri
		(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	/*glTexParameteri
		(GL_TEXTURE_CUBE_MAP, GL_GENERATE_MIPMAP, GL_TRUE);*/

	glActiveTexture (GL_TEXTURE0);
	glBindTexture (GL_TEXTURE_CUBE_MAP, tex);

	glEnable (GL_DEPTH_TEST);
	glViewport (0, 0, WIDTH, HEIGHT);

	GLuint const attribute_pos = (GLuint) glGetAttribLocation (prog, "pos");
	if (attribute_pos == (GLuint) -1) {
		error = __LINE__;
		goto end;
	}

	glVertexAttribPointer (attribute_pos, 2, GL_FLOAT, GL_FALSE, 0,	0);
	glEnableVertexAttribArray (attribute_pos);

	GLint const uniform_depth = glGetUniformLocation (prog, "depth");
	if (uniform_depth == -1) {
		logi ("GL uniform 'depth' not found");
	}

	GLint const uniform_mvp = glGetUniformLocation (prog, "mvp");
	if (uniform_mvp == -1) {
		logi ("GL uniform 'mvp' not found");
	}

	GLint const uniform_mv = glGetUniformLocation (prog, "mv");
	if (uniform_mv == -1) {
		logi ("GL uniform 'mv' not found");
	}

	GLint const uniform_color = glGetUniformLocation (prog, "color");
	if (uniform_color == -1) {
		logi ("GL uniform 'color' not found");
	}

	GLint const uniform_uvscale = glGetUniformLocation (prog, "uvscale");
	if (uniform_uvscale == -1) {
		logi ("GL uniform 'uvscale' not found");
	}

	GLint const uniform_texture = glGetUniformLocation (prog, "texture");
	if (uniform_texture== -1) {
		logi ("GL uniform 'texture' not found");
	}

	float mcam [4 * 4];
    identitymatrix (mcam);
	float move [3] = {0.0f, 0.0f, -20.0f};
	translatematrix (mcam, move);
	float axisz [3] = {0.0f, 0.0f, 1.0f};
	rotatematrix (mcam, M_PI, axisz);

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

	int mouselock = 0;
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
			} else if (evt.type == SDL_QUIT) {
				goto end;
			}
		}

		int ix, iy;
		Uint8 mousebuttons = SDL_GetMouseState(&ix, &iy);

		float x = 0;
		float y = 0;
		if (mouselock == 1) {
			x = ix / ((float) WIDTH) - 0.5f;
			y = iy / ((float) HEIGHT) - 0.5f;
		}

		/*
		if (mousebuttons == SDL_BUTTON(1)) {
			float move [3] = {-x * TRANSLATION_SPEED, y * TRANSLATION_SPEED, 0.0f};
			translatematrix (mcam, move);
		}
		if (mousebuttons == SDL_BUTTON(3)) {
			float axis [3] = {-y, -x, 0.0f};
			float angle = sqrtf (x * x + y * y) * ROTATION_SPEED;
			rotatematrix (mcam, angle, axis);
		}
		if ((mousebuttons & SDL_BUTTON(2)) != 0) {
			if ((mousebuttons & SDL_BUTTON(1)) == 0) {
				float axis [3] = {0.0f, 0.0f, 1.0f};
				float angle = -x * ROTATION_SPEED;
				rotatematrix (mcam, angle, axis);
			} else {
				float move [3] = {0.0f, 0.0f, y * TRANSLATION_SPEED};
				translatematrix (mcam, move);
			}
		}*/
		float axis [3] = {-y, -x, 0.0f};
		float angle = sqrtf (x * x + y * y) * ROTATION_SPEED;
		float move [3] = {0.0f, 0.0f, y * TRANSLATION_SPEED};

		if (mousebuttons == SDL_BUTTON(1)) {
			float matrix [4 * 4];
			identitymatrix (matrix);
			rotatematrix (matrix, angle, axis);
			multiplymatrix (matrix, mcam);
			memcpy (mcam, matrix, sizeof (float) * 16);
		}
		if (mousebuttons == SDL_BUTTON(3)) {
			float axis [3] = {-y, -x, 0.0f};
			float angle = sqrtf (x * x + y * y) * ROTATION_SPEED;
			rotatematrix (mcam, angle, axis);
		}
		if (mousebuttons == SDL_BUTTON(2)) {
			translatematrix (mcam, move);
		}

		if (mousebuttons != 0) {
			SDL_ShowCursor (0);
			SDL_SetWindowGrab (window, SDL_TRUE);
			SDL_WarpMouseInWindow (window, WIDTH / 2, HEIGHT / 2);
			mouselock = 1;
		} else {
			SDL_ShowCursor (1);
			SDL_SetWindowGrab (window, SDL_FALSE);
			mouselock = 0;
		}

		/*hotcheck ();
		glUseProgram (prog);*/

		double time = (double) SDL_GetTicks () / 1000;

		glClearColor (0.0, 0.0, 0.0, 0.0);
		glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		float mview [4 * 4];
		memcpy (mview, mcam, sizeof (mview));
		invertspecialmatrix (mview);

		struct sysplanet * item;
		TAILQ_FOREACH(item, &list, _) {
			float tosurface;
			float apparentratio;
			float mmodel [4 * 4];
			float mrot [4 * 4];
			planetmatrix (&item->planet, time, mcam, mmodel, mrot,
				&tosurface, &apparentratio);

			float matrix [4 * 4];

			float const aspect = ((float) WIDTH) / HEIGHT;
			projectionmatrix (settings.fov, aspect, 0.0f, matrix);
			multiplymatrix (matrix, mview);
			multiplymatrix (matrix, mmodel);
			glUniformMatrix4fv (uniform_mvp, 1, GL_FALSE, matrix);

			float mtmp [4 * 4];
			memcpy (mtmp, mview, sizeof (float) * 16);
			multiplymatrix (mtmp, mview);
			multiplymatrix (mtmp, mrot);
			glUniformMatrix4fv (uniform_mv, 1, GL_FALSE, mtmp);

			float const hack = logf (tosurface) / 1000.0f;
			glUniform1f (uniform_depth, hack);

			glUniform1f (uniform_uvscale, apparentratio);
			glUniform3fv (uniform_color, 1, item->planet.color);

			glUniform1i (uniform_texture, 0);

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
		glDeleteTextures (1, &tex);
		glDeleteProgram (prog);
	}

	if (sdlerror != 0) {
		logi ("SDL error: %s.", SDL_GetError ());
	}

	if (context != NULL) {
		SDL_GL_DeleteContext (context);
	}

	SDL_Quit ();
	IMG_Quit ();

	if (error) {
		logi ("Error # %d.", error);
		return (EXIT_FAILURE);
	}

	return (EXIT_SUCCESS);
}

