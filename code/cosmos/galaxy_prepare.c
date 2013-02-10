struct galaxy_helper
galaxy_prepare (
        struct planetB const * galaxy,
        struct galaxy_helper const * gh,
        unsigned planet_number
) {
    struct galaxy_helper result;

    unsigned PLACEHOLDER = 2;
    float const size_constant = 0.9;

    struct planetB const * planet = galaxy + planet_number;

    if (planet_number == 0) {
        result.transform = mat4_identity ();
        result.size = 1.0;
    } else {
        unsigned parent = planet->where.parent_index;
        assert (parent < planet_number);

        vec3 offset = {{0}};
        unsigned PLACEHOLDER = 3;
        float distance = gh[parent].size * planet->where.orbit_number;
        float alpha = (2.0f * pi () * planet->where.orbit_slot) / PLACEHOLDER;

        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        result.transform = mat4_moved (& gh[parent].transform, & offset);
        result.size = gh[parent].size;

    }

    result.size *= size_constant / PLACEHOLDER;

    return result;
}
