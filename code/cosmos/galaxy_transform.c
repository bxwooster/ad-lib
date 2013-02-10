mat4 
galaxy_transform (
        struct planetB * galaxy,
        mat4 * galaxy_helper,
        unsigned planet_number
) {
    struct planetB const * planet = galaxy + planet_number;
    
    if (planet_number == 0) {
        return mat4_identity ();
    } else {
        unsigned index = planet->where.parent_index;
        assert (index < planet_number);

        vec3 offset = {{0}};
        unsigned PLACEHOLDER = 3;
        float distance = 1.0f * planet->where.orbit_number;
        float alpha = 360.0f * planet->where.orbit_slot / PLACEHOLDER;

        offset.element.x = sinf (alpha) * distance;
        offset.element.y = cosf (alpha) * distance;

        mat4 transform = mat4_moved (& galaxy_helper[index], & offset);

        return transform;
    }
}
