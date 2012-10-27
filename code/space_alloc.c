space
space_alloc (
        size_t size
) {
    char * buf = malloc (size);
    char * end = (buf == NULL ? NULL : buf + size);
    return (space) {buf, buf, end};
}
