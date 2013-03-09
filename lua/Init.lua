function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    core = ffi.C

    core.Pull ("Lib")
    core.Pull ("Loop")
    core.Pull ("KeyDefs")

    world = InitWorld ()
end

function InitWorld ()
    local world = {}
    world.nodes = {}
    world.spheres = {}
    world.orbitholders = {}

    local pc = {tmat = mat4.id}
    local p1 = {
        rmat = mat4.Movement (vec3.left),
        radius = 0.5, parent = pc,
        orbits = {
            {width = 1, cells = 3},
            {width = 1, cells = 5}
        }
    }

    table.insert (world.nodes, p1)
    table.insert (world.spheres, p1)
    table.insert (world.orbitholders, p1)

    local pos = vec3.New (0.0, 1.7, 1.0)
    local angle = 0.7 * math.pi
    world.camera = {
        speed = 1.0,
        tmat = core.mat4_rotated_aa (mat4.Movement (pos), vec3.right, angle)
    }
    
    return world
end
