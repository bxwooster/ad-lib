struct planet_day {
    vec3 axis;
    float period;
};

struct planet {
    char name [16];
    struct {
        unsigned parent_index;
        unsigned orbit_number;
        unsigned orbit_slot;
    } where;
    unsigned orbit_count;
	vec3 colour;
    struct planet_day day;
};

struct galaxy {
    struct planet * planets;
    unsigned size;
};
