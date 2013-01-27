char * // contents
load_glts_file (
        char const * id_starts,
        char const * id_ends_or_null
) {        
    char prefix [] = "data/tsh/";
    char suffix [] = ".glsl";

    size_t id_size = id_ends_or_null ?
        (size_t) (id_ends_or_null - id_starts) :
        strlen (id_starts);
    size_t size = sizeof(prefix) + id_size + sizeof(suffix) + 1;

    char * included_file = alloca (size);
    snprintf (included_file, size, "%s%.*s%s",
        prefix, (int) id_size, id_starts, suffix); 

    return load_file (included_file);
}
