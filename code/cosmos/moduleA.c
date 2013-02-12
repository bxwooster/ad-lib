void moduleA (
        struct stone_engine * E,
        struct frame_DD * framedata
) {
    unsigned j = 0;
    for (struct planetlistA_element *
            item = E->planet_list->first;
            item != NULL;
            item = item->_.next
    ) {
        struct planet_ID pid;
        planet_ID_from_A (E->time, & pid, & item->planet);
        E->planet_memory[j] = generate_planet_DD (
                & pid,
                framedata
        );
        j++;
    }
}

