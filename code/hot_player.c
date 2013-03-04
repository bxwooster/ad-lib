#ifdef HOTREMOTE
char * hot_play (struct hot_player * H, char * filename) {
/* equivalent of load_file */
    struct packet original;

    /* question */
    {
        size_t size = strlen (filename);

        size_t packlen = sizeof (struct packet) + size;
        OK (packlen < SCRATCH_SIZE);
        struct packet * pack = (void *) H->scratch;
        pack->type = TYPE_PULL_REQUEST;
        pack->id = htonl (H->last_id);
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

struct hot_player * hot_new_player (void) {
    logi ("Just to be sure, sizeof (packet) is %zd.", sizeof(struct packet));
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
    free (answer);
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
            T->call (T->data, answer);
            free (answer);
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
