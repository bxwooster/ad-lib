function Loop ()
	-- update Time, Dt
    DoTime ()

	-- update rings. Must be done before nodes
    apply (UpdateRing, World.rings)

	-- update nodes of the 3D transform hierarchy 
    apply (UpdateNode, World.nodes)

	-- update Lock
	DoLock ()

	-- camera updated and sent to core
    UpdateCamera (World.camera)

	-- TODO: needs renaming/splitting
    apply (HoverInSystem, World.systems)

	-- TODO: rename/return value?
    Highlight ()

	-- Draw all the "spheres" (but each has an Earth texture ATM)
    core.PreSphere ()
    apply (DrawSphere, World.spheres)

	-- Draw all the sectors
    core.PreSector ()
    apply (DrawSector, World.sectors)

	-- Update World.turn
    DoTurn ()

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function DoLock ()
    local C = World.camera.tMat.c.w.v3
    local V = core.ScreenRay (core.Pointer ())
    Lock = core.PlaneIntersection (C, V, vec3.z, vec3.zero)
end

function Highlight ()
    Selected = {}
    if Hovered then
        local sector = Hovered
        Selected[sector] = colour.yellow
        if KeyDown (KEY.P1) then
            if not Start then
                Start = sector
            elseif not End then
                End = sector
            else
                Start = nil
                End = nil
                Path = nil
            end
        end
        for link, f in pairs (sector.links) do
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

function DoTurn ()
	local T = World.turn
    local duration = 2
    local left = T.endTime - Time
    if left > 0 then
        T.float = T.int - left / duration
    elseif KeyDown (KEY.Space) then
        T.int = T.int + 1
        T.endTime = Time + duration
    end
end

function UpdateNode (N)
    N.tMat = N.parent.tMat ^ N.rMat
end

function DrawSphere (S)
    core.Sphere (S.tMat, S.colour, S.radius)
end
