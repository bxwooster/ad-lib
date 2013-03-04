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

void hot_swatchcall (void * data, char * filename) {
    // note: copied from hot_watchcall
    debug ("SW");
    struct hot_server * H = data;

    for (size_t i = 0; i < H->count; i++) {
        struct hot_minithing * T = H->things + i;

        if (0 == strcmp (T->filename, filename)) {
            logi ("Whoa! %s is updated!", filename);
            char * answer = load_file (T->filename);

            hot_push (H, T->id, answer);
        }
    }
}
void hot_push (struct hot_server * H, uint32_t id, char * answer) {
    unsigned size = strlen (answer);

    size_t packlen = sizeof (struct packet) + size;
    OK (packlen + 1 < SCRATCH_SIZE);
    struct packet * pack = (void *) H->scratch;

    pack->type = TYPE_PULL_RESPONSE;
    pack->id = htonl (id);
    pack->size = htonl (size);
    memcpy (pack->data, answer, size);

    send_it (H->real, pack, packlen);
}

void hot_serve (struct hot_server * H) {
/* non-blocking. does everything that's pending */

    for (;;) {
        uint32_t id;
        char * question;
        /* question */
        {
            struct packet * pack = (void *) H->scratch; // alias

            if (!recv_it (H->real, pack, SCRATCH_SIZE, 1)) {
                break;
            }
            OK (pack->type == TYPE_PULL_REQUEST);
            id = ntohl (pack->id);
            OK (id > H->last_id);
            H->last_id = id;

            size_t size = ntohl (pack->size);
            pack->data[size] = '\0';
            question = (char *) pack->data;
            logi ("Question is %s", question);

            // note: copied from hot_pull
            H->count++;
            if (H->capacity < H->count) {
                H->capacity += 16;
                H->things = realloc (H->things,
                       sizeof (struct hot_minithing) * H->capacity);
                OK (H->things != NULL);
            }

            struct hot_minithing * T = H->things + H->count - 1;
            T->id = id;

            size_t filename_size = size + 1;
            T->filename = malloc (filename_size);
            OK (T->filename != NULL);
            memcpy (T->filename, question, filename_size);

            logi ("Added #%lu, %s", T->id, T->filename);
        }

        /* answer */
        {
            char * answer = load_file (question);
            hot_push (H, id, answer);
            free (answer);
        }
    }
    watch_update (H->W, hot_swatchcall, H);
}

