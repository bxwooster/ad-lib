struct watcher {
    HANDLE dir;
    HANDLE event;
    OVERLAPPED over;
};

typedef void (*watch_callback) (void *, char *);
