struct galaxy_helper
galaxy_prepare (
        double time,
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number,
        struct framestate const * state
) {
    struct galaxy_helper result;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        result.transform = mat4_identity ();
        result.supersize = 1.0f;
    } else {
        unsigned parent = planet->where.parent_index;
        assert (parent < planet_number);

        float rest = 0.0f;
        if (state->turn_transition) {
            float ttd = k_turn_transition_delay;
            rest = (time - state->turn_transition_ends + ttd) / ttd;
        }
        float float_slot = planet->where.orbit_slot + state->turn + rest;

        unsigned orbit_slots = planet->where.orbit_number - 1 + 3;
        float alpha = (2.0f * M_PI * float_slot) / orbit_slots;

        float distance = gh[parent].size * (planet->where.orbit_number + 0.5f);

        vec3 offset = {{0}};
        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        result.transform = mat4_moved (& gh[parent].transform, & offset);
        result.supersize = gh[parent].size * 0.5 * k_planet_size_minifier;
    }
    
    result.size = result.supersize / (planet->orbit_count + 1);

    return result;
}
