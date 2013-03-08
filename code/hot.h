struct packet {
    uint8_t type;
    uint32_t id;
    uint32_t size;
    uint8_t data [0];
} __attribute__((packed)); 

typedef void (*hot_callback)
    (void * data, char const * file, char const * text);
