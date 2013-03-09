function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    core = ffi.C

    core.Pull ("Lib")
    core.Pull ("Loop")
    core.Pull ("KeyDefs")

    --[[
    vec3 axis = {{1.0f, 0.0f, 0.0f}};
    float angle = M_PI * 0.7;
    S->rot = mat4_rotated_aa (& one, & axis, angle);
    --]]

    local pc = {tmat = mat4.id}
    local p1 = {
        rmat = mat4.Movement (vec3.left),
        radius = 0.5, parent = pc,
        orbits = {
            {width = 1, cells = 3},
            {width = 1, cells = 5}
        }
    }

    world = {}
    world.nodes = {}
    world.spheres = {}
    world.orbitholders = {}

    table.insert (world.nodes, p1)
    table.insert (world.spheres, p1)
    table.insert (world.orbitholders, p1)

    local inve = vec3.New (0.0, 1.7, 1.0)
    local ang = 0.7 * math.pi
    world.camera = {
        speed = 1.0,
        tmat = core.mat4_rotated_aa (mat4.Movement (inve), vec3.right, ang)
    }
    
end
