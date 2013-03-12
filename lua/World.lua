function NewWorld ()
    local world = {}

    world.nodes = {}
    world.systems = {}
    world.spheres = {}
    world.segments = {}

    world.center = {
        colour = vec3.New (1, 0, 1),
        radius = 1.0,
        tMat = mat4.id,
    }

    local P1 = {
        colour = vec3.New (1, 1, 1),
        radius = 0.5,
        rMat = mat4.Movement (10 * vec3.x),
        parent = world.center,
        orbits = {
            {width = 4, nCells = 3},
            {width = 4, nCells = 5}
        }
    }

    NewSystem (P1, world)
    table.insert (world.nodes, P1)
    table.insert (world.spheres, P1)

    local pos = vec3.New (0.0, 30, 30.0)
    local angle = 0.75 * math.pi
    world.camera = {
        speed = 3,
        tMat = mat4.Movement (pos) ^ mat4.Rotation (vec3.x, angle),
    }

    world.turn = {
        int = 0,
        float = 0,
        endTime = 0
    }

    return world
end
