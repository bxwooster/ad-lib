static struct stone_engine * XE = NULL;

void X_init(struct stone_engine * E) {
    XE = E;
}

API int8_t XKeyboard (unsigned key) {
    if (key >= XE->keyboard_max) return 0;
    return XE->keyboard[key];
}

API void XSetWireframe (char show) {
    XE->show_wireframe = show;
}

API void XSetNormalview (char show) {
    XE->show_normals = show;
}

API void XHalt () {
    XE->halt = 1;
}

API void XPull (char const * func) {
    char * file = func2file (func);
    hot_pull (XE->H, file, lua_hot, XE, 0);
    free (file);
}

