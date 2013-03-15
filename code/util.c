static unsigned const k_segment_quads = 64;

GLenum // GLformat
util_earth_load (SDL_Surface * earth [6]) {
    char const * const earthimg [6] = {
        "art/earth/posx.jpg",
        "art/earth/negx.jpg",
        "art/earth/posy.jpg",
        "art/earth/negy.jpg",
        "art/earth/posz.jpg",
        "art/earth/negz.jpg",
    };

    for (int i = 0; i < 6; ++i) {
        earth[i] = IMG_Load (earthimg[i]);
        if (earth[i] == NULL) {
            logi ("SDL_image error: %s", IMG_GetError ());
            return GL_FALSE;
        }
    }

    Uint32 sdlformat = earth[0]->format->format;

    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB24) return GL_RGB;
    if (sdlformat == (Uint32) SDL_PIXELFORMAT_RGB888) return GL_BGRA;

    logi ("Unexpected texture format: %s",
        SDL_GetPixelFormatName (sdlformat)); 
    OK (0);
    return GL_FALSE;
}

GLuint // tex
util_earth_prepare (
        SDL_Surface * earth [6],
        GLenum GLformat
) {
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

	GLenum min_filter = GL_NEAREST_MIPMAP_LINEAR;
#else
	GLenum min_filter = GL_NEAREST;
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

GLuint // tex
util_earth (void) {
    SDL_Surface * earth [6] = {0};
    GLenum GLformat = util_earth_load (earth);

    GLuint tex = util_earth_prepare (earth, GLformat);

    for (int i = 0; i < 6; i++) {
        SDL_FreeSurface (earth[i]);
    }

    return tex;
}

struct GLvbo_and_size
util_imposter (void) {
    float const y = (float) (1.0 - sqrt(2.0));

    struct {
        float x;
        float y;
    } const tris [] [3] = {
        {{0, 0}, {+1,-y}, {+1,+y}},
        {{0, 0}, {+1,+y}, {-y,-1}},
        {{0, 0}, {-y,-1}, {+y,-1}},
        {{0, 0}, {+y,-1}, {-1,+y}},
        {{0, 0}, {-1,+y}, {-1,-y}},
        {{0, 0}, {-1,-y}, {+y,+1}},
        {{0, 0}, {+y,+1}, {-y,+1}},
        {{0, 0}, {-y,+1}, {+1,-y}},
    };
    unsigned vertices = sizeof (tris) / sizeof (tris[0][0]);

    GLuint vbo;
    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    return (struct GLvbo_and_size) {vbo, vertices};
}

struct GLvbo_and_size
util_segment (void) {
    unsigned N = k_segment_quads;

    struct {
        float x;
        float y;
    } tris [N] [6];

    for (unsigned i = 0; i < N; ++i) {
        float j = i + 1;
        tris[i][0].x = 0; tris[i][0].y = j;
        tris[i][1].x = 1; tris[i][1].y = j;
        tris[i][2].x = 1; tris[i][2].y = i;
        tris[i][3].x = 0; tris[i][3].y = j;
        tris[i][4].x = 1; tris[i][4].y = i;
        tris[i][5].x = 0; tris[i][5].y = i;
    };
    unsigned vertices = sizeof (tris) / sizeof (tris[0][0]);

    GLuint vbo;
    glGenBuffers (1, &vbo);
    glBindBuffer (GL_ARRAY_BUFFER, vbo);
    glBufferData (GL_ARRAY_BUFFER, sizeof (tris), tris, GL_STATIC_DRAW);

    return (struct GLvbo_and_size) {vbo, vertices};
}

mat4
util_projection_afn (
		float aspect_ratio,
		float fov_horizontal_in_degrees,
		float near_plane_distance
) {
    mat4 out;

	float q = 1 / tanf (M_PI / 180 / 2 * fov_horizontal_in_degrees);

	out.p[0] = q;
	out.p[1] = 0.0f;
	out.p[2] = 0.0f;
	out.p[3] = 0.0f;

	out.p[4] = 0.0f;
	out.p[5] = q * aspect_ratio;
	out.p[6] = 0.0f;
	out.p[7] = 0.0f;
	
	out.p[8] = 0.0f;
	out.p[9] = 0.0f;
	out.p[10] = 1.0f;
	out.p[11] = 1.0f;

	out.p[12] = 0.0f;
	out.p[13] = 0.0f;
	out.p[14] = -2.0f * near_plane_distance;
	out.p[15] = 0.0f;

    return out;
}

mat4 // proj
util_projection (
        unsigned width,
        unsigned height,
        float fov
) {
    float const screen_aspect = ((float) width) / height;
    return util_projection_afn (screen_aspect, fov, 0.1f);
} 
