void * cutmem (struct mem * ory, size_t size, size_t align) {
    assert ((align & (align-1)) == 0);
    char * ptr = (char *) ((align-1 + (uintptr_t) ory->head) & ~(align-1));
    char * end = ptr + size;
    if (end > ory->end) { return NULL; }
    ory->head = end;
    return ptr;
}

