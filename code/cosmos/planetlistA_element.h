#pragma once
struct planetlistA_element {
	struct planetA planet;
	char * file;
    struct {
        struct planetlistA_element *next;	/* next element */
        struct planetlistA_element **prev; /* address of previous next (sic) element */
    } _;
};

