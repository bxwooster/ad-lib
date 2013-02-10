int // status
loadplanet (
        struct planetA * planet,
        char const * file
) {
    int error = 0;
    FILE * fp = NULL;
    struct planetA read;

    if ((fp = fopen (file, "rb")) == 0 ||
        fscanf (fp, " size: %f", &read.size) != 1 ||
        fscanf (fp, "; colour: %f, %f, %f",
            read.colour.p,
            read.colour.p + 1,
            read.colour.p + 2) != 3 ||
        fscanf (fp, " ; year: { major: %f", &read.year.major) != 1 ||
        fscanf (fp, " ; minor: %f", &read.year.minor) != 1 ||
        fscanf (fp, " ; period: %f", &read.year.period) != 1 ||
        fscanf (fp, " ; } ; day: { axis: %f, %f, %f",
            read.day.axis.p,
            read.day.axis.p + 1,
            read.day.axis.p + 2) != 3 ||
        fscanf (fp, " ; period: %f", &read.day.period) != 1 ||
        fscanf (fp, " ; } ; ")
    ) {
        error = __LINE__;
        goto end;
    }

    fscanf (fp, " ");
    if (fgetc (fp) != EOF) {
        error = __LINE__;
        goto end;
    }

    *planet = read;

    end:

    if (fp != NULL) {
        fclose (fp);
    }

    return (error);
}

