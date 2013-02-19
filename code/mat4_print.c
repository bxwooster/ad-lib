void
mat4_print (
        mat4 const * m
) {
    for (unsigned i = 0; i < 4; ++i) {
        log_info ("\t( %.3f\t%.3f\t%.3f\t%.3f )",
                m->p[i + 0], m->p[i + 4],
                m->p[i + 8], m->p[i + 12]);
    }
}

