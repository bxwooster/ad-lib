char const * gl_shader_preamble () {
    int gles = 0;
    #ifdef GLES 
        gles = 1;
    #endif
    return gles ?  
        "#version 100\nprecision mediump float;\n" :
        "#version 120\n";
}

