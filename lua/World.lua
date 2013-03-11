function InitWorld ()
    local world = {}
    world.nodes = {}
    world.spheres = {}
    world.orbitholders = {}

    local function genCells (n)
        local cells = {}
        for i = 1, n do
            cells[i] = {colour = vec3.Random (true)}
        end
        return cells
    end

    world.center = {
        colour = vec3.New (1, 0, 1),
        radius = 1.0,
        tMat = mat4.id,
    }

    local P1 = {
        colour = vec3.New (1, 1, 1),
        radius = 0.5,
        rMat = mat4.Movement (5 * vec3.x),
        parent = world.center,
        orbits = {
            {width = 1, cells = genCells (3)},
            {width = 2, cells = genCells (5)}
        }
    }

    local P2 = {
        colour = vec3.New (0, 1, 1),
        radius = 0.3,
        rMat = mat4.Movement (-5 * vec3.y),
        parent = world.center,
        orbits = {
            {width = 2, cells = genCells (10)},
            {width = 1, cells = genCells (2)}
        }
    }

    table.insert (world.nodes, P1)
    table.insert (world.spheres, P1)
    table.insert (world.orbitholders, P1)

    table.insert (world.nodes, P2)
    table.insert (world.spheres, P2)
    table.insert (world.orbitholders, P2)

    table.insert (world.spheres, world.center)

    local pos = vec3.New (2.0, 5.7, 4.0)
    local angle = 0.7 * math.pi
    world.camera = {
        speed = 3,
        tMat = mat4.Movement (pos) ^ mat4.Rotation (vec3.x, angle),
    }

    return world
end
