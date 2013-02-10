#include <planetlistA_element.h>

struct planetlistA_head {
    struct planetlistA_element *first; /* first element */
    struct planetlistA_element **last; /* addr of last next (?? -- ED) element */
};

