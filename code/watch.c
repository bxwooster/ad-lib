int main (int argc, char * argv []) {
    (void) argc;
    (void) argv;

    HANDLE dir = CreateFile (".", FILE_LIST_DIRECTORY,
            FILE_SHARE_DELETE | FILE_SHARE_READ | FILE_SHARE_WRITE,
            NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
    OK (dir != INVALID_HANDLE_VALUE);

    size_t const SIZE = 1024 * 64;
    char * buffer = malloc (SIZE);
    OK (buffer != NULL);
    
    char name [MAX_PATH];
    DWORD bytes_returned;

    for (;;) {
        int code = ReadDirectoryChangesW (dir, buffer, SIZE, 1,
                FILE_NOTIFY_CHANGE_LAST_WRITE, & bytes_returned, NULL, NULL);
        OK (code);

        int offset = 0;
        FILE_NOTIFY_INFORMATION * info;

        do {
            info = (void *) (buffer + offset);
            int size = WideCharToMultiByte (CP_ACP, 0, info->FileName,
                    info->FileNameLength / 2, name, MAX_PATH - 1, NULL, NULL);
            OK (size > 0);
            name [size] = '\0';
            logi ("Action: %d, File: %s", (int) info->Action, name);

            offset += info->NextEntryOffset;
        } while (info->NextEntryOffset != 0);
    }

    free (buffer);
    CloseHandle (dir);

    return 0;
}
