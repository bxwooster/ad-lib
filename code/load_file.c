char * // contents
load_file (
        char const * filename
) {
    char * contents = malloc (strlen (filename) + 1);
    strcpy (contents, filename); // temporary...
    return contents;
}
