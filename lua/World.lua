function NewWorld ()
    local world = {}

    world.nodes = {}
    world.systems = {}
    world.spheres = {}
    world.segments = {}

    world.center = {
        colour = Vec3.New (1, 0, 1),
        radius = 1.0,
        tMat = Mat4.id,
    }

    local P1 = {
        colour = Vec3.New (1, 1, 1),
        radius = 1,
        rMat = Mat4.id,
        parent = world.center,
        orbits = {
            {width = 4, nCells = 3},
            {width = 3, nCells = 5},
            {width = 4, nCells = 63},
            {width = 2, nCells = 7},
            {width = 5, nCells = 9},
            {width = 4, nCells = 20},
        }
    }

    NewSystem (P1, world)
    table.insert (world.nodes, P1)
    table.insert (world.spheres, P1)

    local pos = Vec3.New (0, 20, 60)
    local angle = 0.9 * math.pi
    world.camera = {
        speed = 3,
        tMat = Mat4.Movement (pos) ^ Mat4.Rotation (Vec3.x, angle),
    }

    world.turn = {
        int = 0,
        float = 0,
        endTime = 0
    }

    return world
end
