GLuint // tex
get_earth_GLtex (
        struct GL * gl,
        struct SDL * sdl,
        struct IMG * img
) {
        GLuint tex = GL_FALSE;
        SDL_Surface * earth [6] = {0};

        GLenum GLformat = load_earth (earth, img, sdl);
        if (GLformat != GL_FALSE) {
            tex = prepare_GLtex (earth, GLformat, gl);
        }

        for (int i = 0; i < 6; i++) {
            SDL_FreeSurface (earth[i]);
        }

        return tex;
}
