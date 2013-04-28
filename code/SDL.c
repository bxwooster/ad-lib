API void DebugCallbackARB (
		GLenum source,
		GLenum type,
		GLuint id,
		GLenum severity,
		GLsizei length,
		const GLchar * message,
		GLvoid * userParam
) {
	(void) source;
	(void) type;
	(void) id;
	(void) severity;
	(void) length;
	(void) userParam;
	logi ("%s", message);
}

struct SDL * init_SDL (void) {
    int require = IMG_INIT_JPG;
    int initted = IMG_Init (require);

    OK_ELSE ((require & initted) == require) {
        logi ("SDL_image error: %s.", IMG_GetError ());
    }

    OK_ELSE (SDL_Init (SDL_INIT_VIDEO | SDL_INIT_TIMER) >= 0) {
        logi ("SDL_Init error: %s.", SDL_GetError ());
    }

    unsigned width = 1024;
    unsigned height = 768;
    /* bug: this is the size of the window, not of framebuffer as wanted */


    char attr =
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MAJOR_VERSION, 3) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_MINOR_VERSION, 2) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_STENCIL_SIZE, 8) != 0 ||
        SDL_GL_SetAttribute (SDL_GL_CONTEXT_PROFILE_MASK,
				SDL_GL_CONTEXT_PROFILE_CORE) != 0 ||
		SDL_GL_SetAttribute (SDL_GL_CONTEXT_FLAGS,
				SDL_GL_CONTEXT_DEBUG_FLAG) != 0;

    OK_ELSE (attr == 0) {
        logi ("SDL_GL_SetAttribute error: %s.", SDL_GetError ());
    }

    SDL_Window * window = SDL_CreateWindow ("",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        width, height,
        SDL_WINDOW_OPENGL);

    OK_ELSE (window != NULL) {
        logi ("SDL_CreateWindow error: %s.", SDL_GetError ());
    }

    struct SDL * sdl = malloc (sizeof (*sdl));
    OK (sdl != NULL);

    sdl->window = window;
    sdl->width = width;
    sdl->height = height;

    sdl->GLcontext = SDL_GL_CreateContext (sdl->window);

    OK_ELSE (sdl->GLcontext != NULL) {
        logi ("SDL_GL_CreateContext error: %s.", SDL_GetError ());
    }

#ifdef GLEW
    GLenum glew = glewInit();

    OK_ELSE (glew == GLEW_OK) {
        logi ("GLEW error: %s.", glewGetErrorString (glew));
    }

    OK_ELSE (GLEW_VERSION_3_2) {
        logi ("GL3.2 is not supported.");
    }

	// core profile gives an error with GLEW, mute it
	glGetError();
#endif

    return sdl;
}

void exit_SDL (struct SDL * sdl) {
    SDL_GL_DeleteContext (sdl->GLcontext);
    if (sdl->window != NULL) {
        SDL_DestroyWindow (sdl->window);
    }

    SDL_Quit ();
    free (sdl);
}
