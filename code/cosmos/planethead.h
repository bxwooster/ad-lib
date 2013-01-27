#include <sysplanet.h>

struct planethead {
    struct sysplanet *first; /* first element */
    struct sysplanet **last; /* addr of last next (?? -- ED) element */
};

