void
log_debug (
        char const * fmt,
        ...
) {
    fprintf (stdout, "<#> ");
    va_list args;
    va_start (args, fmt);
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}

