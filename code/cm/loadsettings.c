int loadsettings (struct settings * settings, char const * file) {
    int error = 0;
    FILE * fp = NULL;
    struct settings read;

    if ((fp = fopen (file, "rb")) == 0 ||
        fscanf (fp, "fov: %f", &read.fov) != 1 ||
        fscanf (fp, "\nwidth: %ud", &read.width) != 1 ||
        fscanf (fp, "\nheight: %ud", &read.height) != 1
    ) {
        error = __LINE__;
        goto end;
    }

    fscanf (fp, "\n");
    if (fgetc (fp) != EOF) {
        error = __LINE__;
        goto end;
    }

    *settings = read;

    end:

    if (fp != NULL) {
        fclose (fp);
    }

    return (error);
}

