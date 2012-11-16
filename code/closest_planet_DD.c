int closest_planet_DD (void const * a, void const * b) {
    float a_depth = ((struct planet_DD const *) a)->depth;
    float b_depth = ((struct planet_DD const *) b)->depth;

    return (a_depth > b_depth) ? -1 : 1;
}

