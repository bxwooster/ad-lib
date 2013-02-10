#include <vec3.h>
#include <planet_day.h>
struct planetB {
    char name [16];
    struct {
        unsigned parent_index;
        unsigned orbit_number;
        unsigned orbit_slot;
    } where;
	vec3 colour;
    struct planet_day day;
};

