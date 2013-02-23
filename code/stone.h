struct stone_engine * stone_init
    (struct GL * gl, struct SDL * sdl, struct IMG * img);

char stone_do_frame (struct stone_engine * E);

void stone_destroy (struct stone_engine * E);
