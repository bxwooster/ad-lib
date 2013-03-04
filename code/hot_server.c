struct hot_server * hot_new_server (void) {
    logi ("Just to be sure, sizeof (packet) is %zd.", sizeof(struct packet));
    struct hot_server * H = malloc (sizeof (*H));
    OK (H != NULL);

    H->W = watch_init ();

    H->real = hot_server_socket ();
    H->last_id = 0;
    H->scratch = malloc (SCRATCH_SIZE);
    OK (H->scratch);

    H->things = NULL;
    H->count = 0;
    H->capacity = 0;

    return H;
}

void hot_del_server (struct hot_server * H) {
    closesocket (H->real);
    watch_del (H->W);

    for (size_t i = 0; i < H->count; i++) {
        free (H->things[i].filename);
    }

    free (H->things);
    free (H->scratch);
    free (H);
}

void hot_serve (struct hot_server * H) {
/* non-blocking. does everything that's pending */
    struct packet original;
    char * question;

    for (;;) {
        /* question */
        {
            struct packet * pack = (void *) H->scratch; // alias

            if (!recv_it (H->real, pack, SCRATCH_SIZE, 1)) {
                return;
            }
            OK (pack->type == TYPE_PULL_REQUEST);
            uint32_t id = ntohl (pack->id);
            logi ("id = %lu", id);
            OK (id > H->last_id);
            H->last_id = id;
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
            OK (packlen + 1 < SCRATCH_SIZE);
            struct packet * pack = (void *) H->scratch;
            pack->type = original.type | 1;
            pack->id = original.id;
            pack->size = htonl (size);
            memcpy (pack->data, answer, size);

            send_it (H->real, pack, packlen);
        }
    }
}

