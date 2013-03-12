function Node (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function Sphere (this)
    core.Sphere (this.tMat, this.colour, this.radius)
end

function Segment (this)
    core.Segment (this.parent.tMat, this.colour,
        this.R1, this.R2, this.A, this.phi + this.A * world.turn.float)
end

function Loop ()
    world = world or NewWorld ()
    local newTime = core.Time ()
    dt = newTime - (time or 0)
    time = newTime

    apply (Node, world.nodes)
    apply (System, world.systems)

    Camera (world.camera)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Segment, world.segments)

    Turn (world.turn)

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.R)) then world = NewWorld () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end

function Turn (this)
    local left = this.endTime - time
    if left > 0 then
        this.float = this.int - left / 2
    elseif (KeyDown (KEY.Space)) then
        this.int = this.int + 1
        this.endTime = time + 2
    end
end
