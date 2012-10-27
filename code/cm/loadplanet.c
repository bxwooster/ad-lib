int
loadplanet (
        struct planet * planet,
        char const * file
) {
    int error = 0;
    FILE * fp = NULL;
    struct planet read;

    if ((fp = fopen (file, "rb")) == 0 ||
        fscanf (fp, "size: %f", &read.size) != 1 ||
        fscanf (fp, "\ncolor: %f, %f, %f",
            read.color,
            read.color + 1,
            read.color + 2) != 3 ||
        fscanf (fp, "\nmajor: %f", &read.orbit.major) != 1 ||
        fscanf (fp, "\nminor: %f", &read.orbit.minor) != 1 ||
        fscanf (fp, "\nperiod: %f", &read.orbit.period) != 1
    ) {
        error = __LINE__;
        goto end;
    }

    fscanf (fp, "\n");
    if (fgetc (fp) != EOF) {
        error = __LINE__;
        goto end;
    }

    read.orbit.matrix = mat4_identity ();

    *planet = read;

    end:

    if (fp != NULL) {
        fclose (fp);
    }

    return (error);
}

