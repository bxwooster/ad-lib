void galaxy_del (struct galaxy * G) {
    free (G->planets);
    free (G);
}

struct galaxy * galaxy_parse (char const * text) {
    struct galaxy * G = malloc (sizeof (*G));
    OK (G != NULL);

    G->size = 0;
    G->planets = NULL;

    char name [16];
    char where [22];

    int read = 0;
    char const * in = text;

    for (;;) {
        /* Is there one more? */
        if (sscanf (in, " it's %15[^: ]%n", name, & read) < 1) break;
        in += read;

        /* Yes. We have the memory for it! All the memory, in fact */
        G->size++;
        G->planets = realloc (G->planets, G->size * (sizeof (struct planet)));
        OK (G->planets != NULL);

        struct planet * a = G->planets + G->size - 1;

        /* Go for it */
        memcpy (a->name, name, sizeof (name));
        logi ("name = %s", a->name);

        if (sscanf (in, " : { where : %21[^; ]%n", where, & read) < 1)
            goto syntax_error;
        in += read;

        a->where.parent_index = ~0u;
        if (strcmp (where, "center") != 0) {
            if (sscanf (where, "%[^-]-%u-%u%n", name,
                        & a->where.orbit_number,
                        & a->where.orbit_slot, & read) < 3) goto syntax_error;
            if (where[read] != '\0') goto syntax_error;

            for (unsigned i = 0; i < G->size - 1; ++i) {
                if (strcmp (name, G->planets[i].name) == 0) {
                    a->where.parent_index = i;
                    break;
                }
            }

            if (a->where.parent_index == ~0u) {
                goto syntax_error;
            }
        }

        if (sscanf (in, " ; orbits : %u%n", & a->orbit_count, & read) < 1)
            goto syntax_error;
        in += read;

        if (sscanf (in, " ; colour : %f, %f, %f%n",
                    a->colour.p,
                    a->colour.p + 1,
                    a->colour.p + 2, & read) < 3) goto syntax_error;
        in += read;

        if (sscanf (in, " ; day: { axis: %f, %f, %f%n",
                a->day.axis.p,
                a->day.axis.p + 1,
                a->day.axis.p + 2, & read) < 3) goto syntax_error;
        in += read;

        if (sscanf (in, " ; period: %f%n", & a->day.period, & read) < 1)
            goto syntax_error;
        in += read;

        sscanf (in, " ; } ; } ;%n", & read);
        in += read;
    };

    logi ("Galaxy is %u large", G->size);
    
    return G;

syntax_error:

    logi ("Galaxy: syntax error @ %d", (int) (in - text));
    galaxy_del (G);

    return NULL;
}

