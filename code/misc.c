void logi (char const * fmt, ...) {
    va_list args;
    va_start (args, fmt);
    fprintf (stdout, "<*> ");
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}

char * load_file (char const * filename) {
    long size = -1;

    FILE * fp = fopen (filename, "rb");
    if (fp == NULL) {
        logi ("Could not open file %s at all.", filename);
        return NULL;
    }

    if (
        fseek (fp, 0L, SEEK_END) != 0 ||
        (size = ftell (fp)) < 0
    ) {
        logi ("Could not determine how large file %s is exactly.", filename);
        fclose (fp);
        return NULL;
    }

    char * contents = malloc ((size_t) size + 1);

    if (contents == NULL) {
        logi ("Alas, size %ld proved to be too huge for allocation.", size);
        fclose (fp);
        return NULL;
    }

    if (
        fseek (fp, 0L, SEEK_SET) != 0 ||
        fread(contents, 1, (size_t) size, fp) != (size_t) size
    ) {
        logi ("Contents of file %s could not even be retrieved.", filename);
        fclose (fp);
        free (contents);
        return NULL;
    }

    contents[size] = '\0';

    return contents;
}
