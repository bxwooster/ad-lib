function NewWorld ()
    local world = {}

    world.nodes = {}
    world.rings = {}
    world.systems = {}
    world.spheres = {}
    world.segments = {}

    world.turn = {
        int = 0,
        float = 0,
        endTime = 0
    }

    world.camera = {
        speed = 3,
        tMat = Mat4.Movement (Vec3.New (0, 1.75, 1.5)) ^
            Mat4.Rotation (Vec3.x, 0.75 * math.pi)
    }

    world.center = {tMat = Mat4.id}

    local P1 = {
        colour = Vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 3},
            {width = 2, nCells = 7},
            {width = 2, nCells = 14},
        }
    }
    NewSystem (P1, world)

    local P2 = {
        external = P1.rings[1][4],
        colour = Vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 4},
        }
    }
    NewSystem (P2, world)

    local P3 = {
        external = P1.rings[2][2],
        external2 = P1.rings[2][3],
        colour = Vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 6},
        }
    }
    NewSystem (P3, world)

    return world
end
