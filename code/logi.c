void logi(char const * fmt, ...) {
    va_list args;
    va_start (args, fmt);
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}

