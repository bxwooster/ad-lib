int
load_file (
        char const * filename,
        char * buffer,
        size_t size
) {
    assert (size > strlen (filename));
    strcpy (buffer, filename); //hack
    return 0;
}
