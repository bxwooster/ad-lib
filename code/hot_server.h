struct hot_minithing {
    uint32_t id;
    char * filename;
};

struct hot_server {
#ifdef HOTLOCAL
    struct watcher * W;
#endif
    SOCKET real;

    uint32_t last_id;
    char * scratch;

    struct hot_minithing * things;
    size_t count;
    size_t capacity;
};

