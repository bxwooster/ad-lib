function Loop ()
    World = World or NewWorld ()

    local newTime = Core.Time ()
    Dt = newTime - (Time or 0)
    Time = newTime

    Selected = {}

    Apply (Node, World.nodes)

    Camera (World.camera)

    Apply (System, World.systems)

    if KeyDown (KEY.P3) then
        Start = nil
        End = nil
        Path = nil
    end
    if Start and End and not Path then 
        Path = AStar (Start, End)
    end
    if Path then
        for _, C in ipairs (Path) do
            Selected[C] = Colour.yellow
        end
    end
    if Start then Selected[Start] = Colour.red end
    if End then Selected[End] = Colour.green end

    Core.PreSphere ()
    Apply (Sphere, World.spheres)

    Core.PreSegment ()
    Apply (Segment, World.segments)

    Turn (World.turn)

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then Core.Halt () end
end

function Turn (this)
    local duration = 2
    local left = this.endTime - Time
    if left > 0 then
        this.float = this.int - left / duration
    elseif KeyDown (KEY.Space) then
        this.int = this.int + 1
        this.endTime = Time + duration
    end
end

function Node (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function Sphere (this)
    Core.Sphere (this.tMat, this.colour, this.radius)
end
