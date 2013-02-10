unsigned /* count */
planet_list_from_disk (
        char const * dirname,
        struct planetlistA_head ** out
) {
    unsigned count = 0;
    struct planetlistA_head * list = malloc (sizeof (struct planetlistA_head));
    list->first = NULL;
    list->last = & list->first;

    DIR * sysdir = opendir (dirname);
    if (sysdir == NULL) {
        log_info ("Could not open directory %s.", dirname);
        *out = list;
        return 0;
    }

    struct dirent * dirent = NULL;
    while ((dirent = readdir (sysdir)) != NULL) {
        if (dirent->d_name[0] != '.') {
            size_t len = strlen (dirname) + 1 + strlen (dirent->d_name) + 1;
            struct planetlistA_element * item = malloc (sizeof (*item));
            assert (item != NULL);
            item->file = (char *) malloc (len);
            assert (item->file != NULL);
            
            snprintf (item->file, len, "%s/%s", dirname, dirent->d_name);

            item->_.next = NULL;
            item->_.prev = list->last;
            *list->last = item;
            list->last = &item->_.next;

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

