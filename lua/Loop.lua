function Loop ()
    World = World or NewWorld ()
    DoTime ()
    apply (UpdateRing, World.rings)
    apply (UpdateNode, World.nodes)
    UpdateCamera (World.camera)
    apply (HoverInSystem, World.systems)
    Highlight ()
    core.PreSphere ()
    apply (DrawSphere, World.spheres)
    core.PreSegment ()
    apply (DrawSegment, World.segments)
    DoTurn (World.turn)
    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function Highlight ()
    Selected = {}
    if Hovered then
        local segment = Hovered
        Selected[segment] = colour.yellow
        if KeyDown (KEY.P1) then
            if not Start then
                Start = segment
            elseif not End then
                End = segment
            else
                Start = nil
                End = nil
                Path = nil
            end
        end
        for link, f in pairs (segment.links) do
            if f == true or f (World.turn.int) then
                Selected[link] = colour.magenta
            end
        end
    end
    Hovered = nil
    if Start and End and not Path then
        Path = AStar (Start, End)
    end
    if Path then
        local N = #Path
        for i, C in ipairs (Path) do
            local k = (i - 1) / (N - 1)
            Selected[C] = colour.black * (1 - k) + colour.white * (k)
        end
    end
    if Start then Selected[Start] = colour.black end
    if End then Selected[End] = colour.white end
end

function DoTime ()
    local newTime = core.Time ()
    Dt = newTime - (Time or 0)
    Time = newTime
end

function DoTurn (this)
    local duration = 2
    local left = this.endTime - Time
    if left > 0 then
        this.float = this.int - left / duration
    elseif KeyDown (KEY.Space) then
        this.int = this.int + 1
        this.endTime = Time + duration
    end
end

function UpdateNode (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function DrawSphere (this)
    core.Sphere (this.tMat, this.colour, this.radius)
end
