struct mem mallocmem (size_t size) {
    char * ptr = malloc (size);
    char * end = (ptr == NULL ? NULL : ptr + size);
    return (struct mem) {ptr, end};
}
