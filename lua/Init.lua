function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    core = ffi.C

    core.Pull ("Lib")
    core.Pull ("Loop")
    core.Pull ("KeyDefs")

    local pc = {tmat = mat4.id}
    local p1 = {
        rmat = mat4.Movement (vec3.left),
        radius = 0.5, parent = pc,
        orbits = {
            {width = 1, cells = 3},
            {width = 1, cells = 5}
        }
    }

    nodes = {}
    spheres = {}
    orbitholders = {}

    table.insert (nodes, p1)
    table.insert (spheres, p1)
    table.insert (orbitholders, p1)
end
