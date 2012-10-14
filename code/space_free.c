void space_free (space * where) {
    free (where->buf);
}
