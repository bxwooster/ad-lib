GLuint // tex
prepare_GLtex (
        SDL_Surface * earth [6],
        GLenum GLformat,
        struct GL * gl
) {
    (void) gl;
    GLuint tex;
    glGenTextures (1, &tex);
    glBindTexture (GL_TEXTURE_CUBE_MAP, tex); // ?
#ifndef GLES
    glTexEnvf(GL_TEXTURE_FILTER_CONTROL, GL_TEXTURE_LOD_BIAS, -1.75f);

    GLenum tSTR [] = {
        GL_TEXTURE_WRAP_S,
        GL_TEXTURE_WRAP_T,
        GL_TEXTURE_WRAP_R
    };
    for (int i = 0; i < 3; ++i) {
        glTexParameteri (GL_TEXTURE_CUBE_MAP, tSTR[i], GL_CLAMP_TO_EDGE);
    }
 
    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_GENERATE_MIPMAP,
        GL_TRUE);
#endif

	GLenum min_filter =
#ifndef GLES
        GL_NEAREST_MIPMAP_LINEAR;
#else
        GL_NEAREST;
#endif

    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_TEXTURE_MIN_FILTER,
        min_filter);

    glTexParameteri (
        GL_TEXTURE_CUBE_MAP,
        GL_TEXTURE_MAG_FILTER,
        GL_LINEAR);

    GLenum targets [6] = {
        GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    };

    for (int i = 0; i < 6; ++i) {
        glTexImage2D (targets[i], 0, GL_RGBA, earth[i]->w, earth[i]->h,
            0, GLformat, GL_UNSIGNED_BYTE, earth[i]->pixels);
    }

    return tex;
}

