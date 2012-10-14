int gl_init () {
    GLenum glew = glewInit();
    if (glew != GLEW_OK) {
        log_info ("GLEW error: %s.", glewGetErrorString (glew));
        return 1;
    }

    if (!GLEW_VERSION_2_0) {
        log_info ("GL2 is not supported.");
        return 2;
    }

    return 0;
}

