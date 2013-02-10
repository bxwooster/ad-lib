void
destroy_planet_list (
    struct planetlistA_head * list
) {
    if (list == NULL) return;

    struct planetlistA_element * tvar;

    for (struct planetlistA_element *
            item = list->first;
            item != NULL &&
            (tvar = item->_.next, 1);
            item = tvar
    ) {
        free ((void *) item->file);

        if ((item->_.next) != NULL) {
            item->_.next->_.prev =
                item->_.prev;
        } else {
            list->last = item->_.prev;
        }
        *item->_.prev = item->_.next;

        free ((void *) item);
    }

    free (list);
}

