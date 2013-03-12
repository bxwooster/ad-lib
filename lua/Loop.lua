function Node (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function Sphere (this)
    core.Sphere (this.tMat, this.colour, this.radius)
end

function Orbitholder (this)
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / table.getn(orbit.cells)
        for i,cell in ipairs (orbit.cells) do
            core.Segment (this.tMat, cell.colour,
                R1, R2, A, A * (world.turn.float + i), nil, 0)
        end
        R1 = R2
    end
end

function Loop ()
    world = world or NewWorld ()
    local newTime = core.Time ()
    dt = newTime - (time or 0)
    time = newTime

    apply (Node, world.nodes)

    Camera (world.camera)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Orbitholder, world.orbitholders)

    local left = world.turn.endTime - time
    if left > 0 then
        world.turn.float = world.turn.int - left / 2
    elseif (KeyDown (KEY.Space)) then
        world.turn.int = world.turn.int + 1
        world.turn.endTime = time + 2
    end

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.R)) then world = NewWorld () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
