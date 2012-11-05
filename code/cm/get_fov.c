float
get_fov (void) {
   char * string = load_file ("data/settings/fov");
   if (string == NULL) return 0.0f;

    float fov = atof (string);

    if (fov == 0.0f) {
        log_info ("Can't read FOV.");
    }

    return fov;
}
