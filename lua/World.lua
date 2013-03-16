function NewWorld ()
    world = PrepareWorld ()

    world.camera = {
        speed = 3,
        tMat = mat4.Movement (vec3.New (0, 1.75, 1.5)) ^
            mat4.Rotation (vec3.x, 0.75 * math.pi)
    }

    world.center = {tMat = mat4.id}

    local P1 = {
        colour = vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 3},
            {width = 3, nCells = 7},
            {width = 1, nCells = 65},
            {width = 3, nCells = 5},
        }
    }
    NewSystem (P1, world)

    local P2 = {
        external = P1.rings[1][4],
        colour = vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 3},
        }
    }
    NewSystem (P2, world)

    local P3 = {
        external = P1.rings[3][0],
        external2 = P1.rings[3][1],
        colour = vec3.New (1, 1, 1),
        radius = 1,
        orbits = {
            {width = 1, nCells = 4},
        }
    }
    NewSystem (P3, world)

    return world
end

function PrepareWorld ()
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

    return world
end
