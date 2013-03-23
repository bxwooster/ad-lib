/**************************/
/* a small sample program */
/**************************/

void sample_callback (void * data, char * filename) {
    (void) data;
    logi ("Aha! What's going on with %s?", filename);
}

int watch (int argc, char * argv []) {
    (void) argc;
    (void) argv;

	logi ("Running watch...");
    struct watcher * W = watch_init ();

    for (;;) {
        watch_update (W, sample_callback, NULL);
        sleep (1);
    }

    watch_del (W);

    return 0;
}
