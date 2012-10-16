mat4 mat4_inverted_rtonly (mat4 const * m) {
    mat4 out;

    out.p[0] = m->p[0];
    out.p[5] = m->p[5];
    out.p[10] = m->p[10];

    out.p[4] = m->p[1];
    out.p[8] = m->p[2];
    out.p[9] = m->p[6];

    out.p[1] = m->p[4];
    out.p[2] = m->p[8];
    out.p[6] = m->p[9];

    float x = -m->p[12];
    float y = -m->p[13];
    float z = -m->p[14];

    out.p[12] = (out.p[0]) * x + (out.p[4]) * y + (out.p[ 8]) * z;
    out.p[13] = (out.p[1]) * x + (out.p[5]) * y + (out.p[ 9]) * z;
    out.p[14] = (out.p[2]) * x + (out.p[6]) * y + (out.p[10]) * z;

    out.p[3] = 0.0f;
    out.p[7] = 0.0f;
    out.p[11] = 0.0f;
    out.p[15] = 1.0f;

    return out;
}

