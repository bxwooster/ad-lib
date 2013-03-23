#define BUFSIZE (64 * 1024)

struct watcher {
    HANDLE dir;
    HANDLE event;
    OVERLAPPED over;
    char * buffer;
};

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

    W->buffer = malloc (BUFSIZE);
    OK (W->buffer != NULL);

    watch_internal (W);

    return W;
}

void watch_del (struct watcher * W) {
    CloseHandle (W->dir);
    CloseHandle (W->event);
    free (W->buffer);
    free (W);
}

void watch_internal (struct watcher * W) {
    DWORD bytes_returned;

    int code = ReadDirectoryChangesW (W->dir, W->buffer, BUFSIZE, 1,
            FILE_NOTIFY_CHANGE_LAST_WRITE, & bytes_returned, & W->over, NULL);
    OK (code != 0);
}

void watch_update (struct watcher * W, watch_callback call, void * data) {
    char name [MAX_PATH];

    DWORD bytes_returned;
    int code = GetOverlappedResult (W->dir, & W->over, & bytes_returned, 0);
    OK (code != 0 || GetLastError () == ERROR_IO_INCOMPLETE);

    if (code != 0)
    {
        int offset = 0;
        FILE_NOTIFY_INFORMATION * info;

        do {
            info = (void *) (W->buffer + offset);
            int size = WideCharToMultiByte (CP_ACP, 0, info->FileName,
                    info->FileNameLength / 2, name, MAX_PATH - 1, NULL, NULL);
            OK (size > 0);
            name [size] = '\0';

            /* the slashes are all Windows-wrong */
            char * slash = name;
            while ((slash = strchr (slash, '\\')) != NULL) {
                *slash = '/';
            }

            /* the best bit */
            call (data, name);

            offset += info->NextEntryOffset;
        } while (info->NextEntryOffset != 0);

        watch_internal (W);
    }
}
