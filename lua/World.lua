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
        rMat = mat4.Movement (10 * vec3.x),
        parent = world.center,
        orbits = {
            {width = 4, cells = genCells (3)},
            {width = 4, cells = genCells (5)}
        }
    }

    local P2 = {
        colour = vec3.New (0, 1, 1),
        radius = 0.3,
        rMat = mat4.Movement (-10 * vec3.x),
        parent = world.center,
        orbits = {
            {width = 1, cells = genCells (8)},
            {width = 1, cells = genCells (8)},
            {width = 1, cells = genCells (12)},
            {width = 1, cells = genCells (12)},
            {width = 1, cells = genCells (16)},
            {width = 1, cells = genCells (16)},
            {width = 1, cells = genCells (20)},
            {width = 1, cells = genCells (20)},
        }
    }
--[[
    table.insert (world.spheres, world.center)
--]]

    table.insert (world.nodes, P1)
    table.insert (world.spheres, P1)
    table.insert (world.orbitholders, P1)

    table.insert (world.nodes, P2)
    table.insert (world.spheres, P2)
    table.insert (world.orbitholders, P2)

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
