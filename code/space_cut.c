void * space_cut (space * where, size_t size, size_t align) {
    size_t fff = align - 1;
    assert ((align & fff) == 0);
    char * ptr = (char *) ((fff + (uintptr_t) where->head) & ~fff);
    char * end = ptr + size;
    if (end > where->end) { return NULL; }
    where->head = end;
    return ptr;
}

