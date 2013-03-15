function Loop ()
    World = World or NewWorld ()
    local newTime = Core.Time ()
    Dt = newTime - (Time or 0)
    Time = newTime
    Selected = {}
    apply (UpdateRing, World.rings)
    apply (UpdateNode, World.nodes)
    UpdateCamera (World.camera)
    apply (HoverInSystem, World.systems)
    Highlight ()
    Core.PreSphere ()
    apply (DrawSphere, World.spheres)
    Core.PreSegment ()
    apply (DrawSegment, World.segments)
    DoTurn (World.turn)
    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then Core.Halt () end
end

function Highlight ()
    if Hovered then
        local segment = Hovered
        Selected[segment] = Colour.yellow
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
                Selected[link] = Colour.magenta
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
            print (k)
            Selected[C] = Colour.black * (1 - k) + Colour.white * (k)
        end
    end
    if Start then Selected[Start] = Colour.black end
    if End then Selected[End] = Colour.white end
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
    Core.Sphere (this.tMat, this.colour, this.radius)
end
