void
mat4_print (
        mat4 const * m
) {
    for (unsigned i = 0; i < 4; ++i) {
        log_info ("\t( %.3f\t%.3f\t%.3f\t%.3f )",
                m->p[4*i + 0], m->p[4*i + 1],
                m->p[4*i + 2], m->p[4*i + 3]);
    }
}

