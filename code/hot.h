struct packet {
    uint8_t type;
    uint32_t id;
    uint32_t size;
    uint8_t data [0];
} __attribute__((packed)); 

typedef void (*hot_callback) (void *, char *);

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

    struct hot_thing * things;
    size_t count;
    size_t capacity;
};

