struct mem mallocmem (size_t size) {
    char * buf = malloc (size);
    char * end = (buf == NULL ? NULL : buf + size);
    return (struct mem) {buf, buf, end};
}
