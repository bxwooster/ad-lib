function Loop ()
    world = world or NewWorld ()

    local newTime = core.Time ()
    dt = newTime - (time or 0)
    time = newTime
    selected = {}

    apply (Node, world.nodes)

    Camera (world.camera)

    apply (System, world.systems)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Segment, world.segments)

    Turn (world.turn)

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then world = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function Turn (this)
    local left = this.endTime - time
    if left > 0 then
        this.float = this.int - left / 2
    elseif KeyDown (KEY.Space) then
        this.int = this.int + 1
        this.endTime = time + 2
    end
end

function Node (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function Sphere (this)
    core.Sphere (this.tMat, this.colour, this.radius)
end
