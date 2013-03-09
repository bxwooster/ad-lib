function InitWorld ()
    local world = {}
    world.nodes = {}
    world.spheres = {}
    world.orbitholders = {}

    local function genCells (n)
        local cells = {}
        for i = 1, n do
            cells[i] = { colour = vec3.Random () }
        end
        return cells
    end

    local pc = {tmat = mat4.id}
    local p1 = {
        rmat = mat4.Movement (vec3.x),
        colour = vec3.New (1, 1, 1),
        radius = 0.5, parent = pc,
        orbits = {
            {width = 1, cells = genCells (3)},
            {width = 1, cells = genCells (5)}
        }
    }

    table.insert (world.nodes, p1)
    table.insert (world.spheres, p1)
    table.insert (world.orbitholders, p1)

    local pos = vec3.New (1.0, 5.7, 4.0)
    local angle = 0.7 * math.pi
    world.camera = {
        speed = 3,
        tmat = mat4.Movement (pos):RotatedAA (vec3.right, angle)
    }
    
    return world
end
