void
destroy_planet_list (
    struct planethead * list
) {
    struct sysplanet * item;
    struct sysplanet * tvar;

    TAILQ_FOREACH_SAFE(item, list, _, tvar) {
        free ((void *) item->file);
        TAILQ_REMOVE (list, item, _);
        free ((void *) item);
    }

    free (list);
}

