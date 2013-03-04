struct hot_thing {
    uint32_t id;
    char * filename;
    hot_callback call;
    void * data;
    size_t size;
};

struct hot_player {
#ifdef HOTLOCAL
    struct watcher * W;
#elif defined HOTREMOTE
    SOCKET real;
#endif
    uint32_t last_id;
    char * scratch;

    struct hot_thing * things;
    size_t count;
    size_t capacity;
};

