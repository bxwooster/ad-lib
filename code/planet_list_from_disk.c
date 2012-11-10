unsigned /* count */
planet_list_from_disk (
        struct planethead ** out
) {
    unsigned count = 0;
    struct planethead * list = malloc (sizeof (struct planethead));
    TAILQ_INIT (list);

    char const * const dirname = "data/spawn";
    DIR * sysdir = opendir (dirname);
    if (sysdir == NULL) {
        log_info ("Could not open directory %s.", dirname);
        
    }

    struct dirent * dirent = NULL;
    while ((dirent = readdir (sysdir)) != NULL) {
        if (dirent->d_name[0] != '.') {
            size_t len = strlen (dirname) + 1 + strlen (dirent->d_name) + 1;
            struct sysplanet * item = malloc (sizeof (*item));
            assert (item != NULL);
            item->file = (char *) malloc (len);
            assert (item->file != NULL);
            
            snprintf (item->file, len, "%s/%s", dirname, dirent->d_name);
            TAILQ_INSERT_TAIL (list, item, _);
            count++;

            if (loadplanet (& item->planet, item->file) != 0) {
                log_info ("Could not load planet: %s.", item->file);
                break;
            }
        }
    }

    if (sysdir != NULL) {
        closedir (sysdir);
    }

    *out = list;
    return count;
}

