void logi (char const * fmt, ...) {
    va_list args;
    va_start (args, fmt);
    fprintf (stdout, "<*> ");
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}

void debug (char const * fmt, ...) {
    va_list args;
    va_start (args, fmt);
    fprintf (stdout, "<#> ");
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}

char * /* contents */ load_file (char const * filename) {
    FILE * fp = fopen (filename, "rb");
    OK_ELSE (fp != NULL) {
        logi ("Could not open file %s at all.", filename);
    }

    OK (fseek (fp, 0L, SEEK_END) == 0);

    long size = ftell (fp);
    OK (size >= 0);

    char * contents = malloc ((size_t) size + 1);
    OK (contents);
    contents[size] = '\0';

    OK (fseek (fp, 0L, SEEK_SET) == 0);
    OK (fread(contents, 1, (size_t) size, fp) == (size_t) size);

    return contents;
}

#ifdef WINVER
    unsigned int sleep (unsigned int sec) {
        Sleep (sec * 1000);
        return 0; 
    }

	char * strdup (char const * src) {
		size_t size = strlen (src);
		char * mem = malloc (size + 1);
		strcpy (mem, src);
		return mem;
	}
#endif
