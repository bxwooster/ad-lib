#pragma once
struct sysplanet {
	struct planet planet;
	char * file;
    struct {
        struct sysplanet *next;	/* next element */
        struct sysplanet **prev; /* address of previous next (sic) element */
    } _;
};

