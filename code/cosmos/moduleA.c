void moduleA (
        struct planetlistA_head const * planet_list,
        struct frame_DD const * framedata,
        struct planet_DD * planet_memory
) {
    unsigned j = 0;
    for (struct planetlistA_element *
            item = planet_list->first;
            item != NULL;
            item = item->_.next
    ) {
        struct planet_ID pid;
        planet_ID_from_A (& pid, & item->planet, framedata);
        planet_memory[j] = generate_planet_DD (
                & pid,
                framedata
        );
        j++;
    }

}
