void
exit_IMG (
        struct IMG * img
) {
    if (img->ready) {
        IMG_Quit ();
        img->ready = 0;
    }
}

