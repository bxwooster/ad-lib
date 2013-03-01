struct watcher * watch_init (void) {
    struct watcher * W = malloc (sizeof (*W));
    OK (W != NULL);

    W->dir = CreateFile (".", FILE_LIST_DIRECTORY,
            FILE_SHARE_DELETE | FILE_SHARE_READ | FILE_SHARE_WRITE,
            NULL, OPEN_EXISTING,
            FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED, NULL);
    OK (W->dir != INVALID_HANDLE_VALUE);

    W->event = CreateEvent (NULL, 0, 0, NULL);
    OK (W->event != INVALID_HANDLE_VALUE);

    W->over = (OVERLAPPED) {0};
    W->over.hEvent = W->event;

    return W;
}

void watch_del (struct watcher * W) {
    CloseHandle (W->dir);
    CloseHandle (W->event);
    free (W);
}

void watch_update (struct watcher * W, watch_callback call, void * data) {
    size_t const SIZE = 1024 * 64;
    char buffer [SIZE];

    char name [MAX_PATH];
    DWORD bytes_returned;

    for (;;) {
        int code = ReadDirectoryChangesW (W->dir, buffer, SIZE, 1,
                FILE_NOTIFY_CHANGE_LAST_WRITE, & bytes_returned, & W->over, NULL);
        OK (code);

        DWORD result = WaitForMultipleObjects (1, & W->event, 0, 0);
        OK (result == 0 || result == WAIT_TIMEOUT);
        if (result == 0) {
            int offset = 0;
            FILE_NOTIFY_INFORMATION * info;

            do {
                info = (void *) (buffer + offset);
                int size = WideCharToMultiByte (CP_ACP, 0, info->FileName,
                        info->FileNameLength / 2, name, MAX_PATH - 1, NULL, NULL);
                OK (size > 0);
                name [size] = '\0';

                /* the best bit */
                call (data, name);

                offset += info->NextEntryOffset;
            } while (info->NextEntryOffset != 0);
        }
    }
}

/**************************/
/* a small sample program */
/**************************/

void sample_callback (void * data, char * filename) {
    (void) data;
    logi ("Aha! What's going on with %s?", filename);
}

int watch (int argc, char * argv []) {
    (void) argc;
    (void) argv;

    struct watcher * W = watch_init ();

    for (;;) {
        watch_update (W, sample_callback, NULL);
        sleep (1);
    }

    watch_del (W);

    return 0;
}

