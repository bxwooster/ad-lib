void logi (char const * fmt, ...) {
    va_list args;
    va_start (args, fmt);
    fprintf (stdout, "<*> ");
    vfprintf (stdout, fmt, args);
    fprintf (stdout, "\n");
    va_end (args);
}
