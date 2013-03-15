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
        scale = 2,
        rMat = Mat4.id,
        parent = world.center,
        orbits = {
            {width = 2, nCells = 3},
            {width = 2, nCells = 7},
        }
    }

    NewSystem (P1, world)

    local P2 = {
        colour = Vec3.New (1, 1, 1),
        radius = 1,
        scale = 0.33,
        rMat = Mat4.Movement (Vec3.x * -1.6),
        parent = P1,
        orbits = {
            {width = 1, nCells = 4},
        }
    }

    NewSystem (P2, world)

    local pos = Vec3.New (0, 1, 4)
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
