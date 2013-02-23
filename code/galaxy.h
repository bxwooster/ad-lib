struct planet_day {
    vec3 axis;
    float period;
};

struct planetB {
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

int // status
galaxy_parse (
        char const * in,
        struct planetB galaxy [],
        unsigned * count
);
