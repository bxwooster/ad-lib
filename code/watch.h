struct watcher {
    HANDLE dir;
    HANDLE event;
    OVERLAPPED over;
    char * buffer;
};

typedef void (*watch_callback) (void *, char *);
