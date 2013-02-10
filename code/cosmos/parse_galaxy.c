int // status
parse_galaxy (
        char const * in,
        struct planetB galaxy [],
        unsigned * count
) {
    int read = 0;

    char name [16];
    char where [22];

    struct planetB * a = galaxy;
    unsigned left = *count;
    *count = 0;

    for (;;) {
        /* Is there one more? */
        if (sscanf (in, " it's %15[^: ]%n", name, & read) < 1) break;
        in += read;

        /* Yes. Do we have the memory for it? */
        if (left == 0) {
            log_info ("Exhausted the provided list while parsing a galaxy!");
            return 2;
        }

        /* Go for it */
        memcpy (a->name, name, sizeof (name));
        log_debug ("name = %s", a->name);

        if (sscanf (in, " : { where : %21[^; ]%n", where, & read) < 1)
            goto syntax_error;
        in += read;

        a->where.parent_index = ~0u;
        if (strcmp (where, "center") != 0) {
            if (sscanf (where, "%[^-]-%u-%u%n", name,
                        & a->where.orbit_number,
                        & a->where.orbit_slot, & read) < 3) goto syntax_error;
            if (where[read] != '\0') goto syntax_error;

            for (unsigned i = 0; i < *count; ++i) {
                if (strcmp (name, galaxy[i].name) == 0) {
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
        
        (*count)++;
        left--;
        a++;
    };

    return 0;

syntax_error:

    log_info ("Galaxy-parsing ended up in a tumult!");
    return 1;
}

