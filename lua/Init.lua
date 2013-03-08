function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    core = ffi.C

    core.Pull ("Lib")
    core.Pull ("Loop")
    core.Pull ("KeyDefs")

    local pc = {tmat = core.mat4_identity ()}
    local p1 = {
        rmat = core.mat4_movement (core.vec3_new (1, 0, 0)),
        radius = 0.5, parent = pc,
        orbits = {
            {width = 1, cells = 3},
            {width = 1, cells = 5}
        }
    }

    spheres = {}
    transforms = {}
    orbitholders = {}

    table.insert (spheres, p1)
    table.insert (transforms, p1)
    table.insert (orbitholders, p1)
end
