uint8_t const TYPE_PULL_REQUEST  = 2 | 0;
uint8_t const TYPE_PULL_RESPONSE = 2 | 1;

void send_it (SOCKET real, struct packet * pack, size_t packlen) {
    size_t sent;
    for (size_t offset = 0; offset < packlen; offset += sent) {
        char * buffer = (char *) pack + offset;
        size_t left = packlen - offset;
        sent = send (real, (void *) buffer, left, 0);
        OK (sent > 0);
    }
}

char recv_it (SOCKET real, struct packet * pack, size_t maxlen,
       char nonblocking) {
    char * buffer = (void *) pack;
    OK (maxlen > sizeof (*pack));

    u_long mode = nonblocking;
    int status = ioctlsocket (real, FIONBIO, & mode);
    OK (status == 0);

    status = recv (real, (void *) buffer, sizeof (*pack), 0);
    if (nonblocking && status == SOCKET_ERROR && socket_wouldblock ()) return 0;
    OK (status == sizeof (*pack));
    buffer += sizeof (*pack);

    mode = 0;
    status = ioctlsocket (real, FIONBIO, & mode);
    OK (status == 0);

    size_t size = ntohl (pack->size);
    ssize_t recd = recv (real, (void *) buffer, size, 0);
    OK ((size_t) recd == size);

    return 1;
}

void hot_serve (SOCKET real) {
/* non-blocking. does everything that's pending */
    uint32_t last_id = 0;

    struct packet original;
    char * question;

    for (;;) {
    /* question */
    {
        char rawbuf [1024];
        struct packet * pack = (void *) rawbuf; // alias

        if (!recv_it (real, pack, 1024, 1)) {
            return;
        }
        OK (pack->type == TYPE_PULL_REQUEST);
        uint32_t id = ntohl (pack->id);
        OK (id > last_id);
        last_id = id;
        original = *pack;

        pack->data[ntohl (pack->size)] = '\0';
        logi ("Question is %s", pack->data);
        question = (char *) pack->data;
    }

    /* answer */
    {
        char * answer = load_file (question);
        unsigned size = strlen (answer);

        size_t packlen = sizeof (struct packet) + size;
        struct packet * pack = malloc (packlen);
        OK (pack != NULL);
        pack->type = original.type | 1;
        pack->id = original.id;
        pack->size = htonl (size);
        memcpy (pack->data, answer, size);

        send_it (real, pack, packlen);

        free (pack);
    }
    }
}

#ifdef HOTREMOTE
char * hot_play (struct hot_player * H, char * filename) {
/* equivalent of load_file */
    uint32_t last_id = 0;
    struct packet original;

    /* question */
    {
        size_t size = strlen (filename);

        size_t packlen = sizeof (struct packet) + size;
        OK (packlen < SCRATCH_SIZE);
        struct packet * pack = (void *) H->scratch;
        pack->type = TYPE_PULL_REQUEST;
        pack->id = htonl (++last_id);
        pack->size = htonl (size);
        memcpy (pack->data, filename, size);

        send_it (H->real, pack, packlen);
        original = *pack;
    }

    /* answer */
    {
        struct packet * pack = (void *) H->scratch; // alias

        recv_it (H->real, pack, SCRATCH_SIZE - 1, 0);
        pack->data[ntohl (pack->size)] = '\0';

        OK (pack->id == original.id);
        OK (pack->type == (original.type | 1));

        logi ("Answer (truncated to 10c) is %.10s", pack->data);

        return (char *) pack->data;
    }
}
#endif

size_t const SCRATCH_SIZE = 65536;

struct hot_player * hot_new_player (void) {
    struct hot_player * H = malloc (sizeof (*H));
    OK (H != NULL);

#ifdef HOTREMOTE
    H->real = hot_player_socket ();
#elif defined HOTLOCAL
    H->W = watch_init ();
#endif
    H->last_id = 0;
    H->scratch = malloc (SCRATCH_SIZE);
    OK (H->scratch);
    H->things = NULL;
    H->count = 0;
    H->capacity = 0;

    return H;
}

void hot_del_player (struct hot_player * H) {
#ifdef HOTREMOTE
    closesocket (H->real);
#elif defined HOTLOCAL
    watch_del (H->W);
#endif
    for (size_t i = 0; i < H->count; i++) {
        free (H->things[i].filename);
        if (H->things[i].size > 0) {
            free (H->things[i].data);
        }
    }
    free (H->things);
    free (H->scratch);
    free (H);
}

uint32_t hot_pull (struct hot_player * H,
        char * filename, hot_callback call, void * data, size_t size) {
    H->count++;
    if (H->capacity < H->count) {
        H->capacity += 16;
        H->things = realloc (H->things,
               sizeof (struct hot_thing) * H->capacity);
        OK (H->things != NULL);
    }

    struct hot_thing * T = H->things + H->count - 1;

    T->id = H->last_id++;
    T->call = call;
    if (size == 0) {
        T->data = data;
    } else {
        T->data = malloc (size);
        OK (T->data);
        memcpy (T->data, data, size);
    }
    T->size = size;

    size_t filename_size = strlen (filename);
    size_t nullterm = 1;
    T->filename = malloc (filename_size + nullterm);
    OK (T->filename != NULL);
    memcpy (T->filename, filename, filename_size);
    T->filename[filename_size] = '\0';

#ifndef HOTREMOTE
    char * contents = load_file (filename);
    call (data, contents);
    free (contents);
#else
    char * answer = hot_play (H, T->filename);
    T->call (T->data, answer);
#endif
    return T->id;
}

void hot_watchcall (void * data, char * filename) {
    struct hot_player * H = data;

    for (size_t i = 0; i < H->count; i++) {
        struct hot_thing * T = H->things + i;

        if (0 == strcmp (T->filename, filename)) {
            logi ("Whoa! %s is updated!", filename);
            char * answer = load_file (T->filename);
            // note that answer's lifetime is short
            T->call (T->data, answer);
        }
    }
}

void hot_check (struct hot_player * H) {
    (void) H;
#ifdef HOTREMOTE
    struct packet * pack = (void *) H->scratch; // alias

    if (recv_it (H->real, pack, SCRATCH_SIZE - 1, 1)) {
        pack->data[ntohl (pack->size)] = '\0';
        if (pack->type != TYPE_PULL_RESPONSE) {
            logi ("Warning: packet of unexpected type %hhu has arrived.",
                    pack->type);
        }
        uint32_t id = ntohl (pack->id);
        for (size_t i = 0; i < H->count; i++) {
            struct hot_thing * T = H->things + i;
            
            if (T->id == id) {
                T->call (T->data, (char *) pack->data);
                return;
            }
        }
        logi ("Warning: packet with unexpected ID %lu", id);
    }
#elif defined HOTLOCAL
    watch_update (H->W, hot_watchcall, H);
#endif
}
