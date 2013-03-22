function Loop ()
	PrepareGL ()

    UpdateTimers ()

	-- Update World.turn
    DoTurn ()

	-- update rings. Must be done before nodes
    apply (UpdateRing, World.rings)

	-- update nodes of the 3D transform hierarchy 
    apply (UpdateNode, World.nodes)

	-- camera updated and sent to core
    UpdateCamera (World.camera)

	-- where is the pointer hovering on the 2D ground plane?
	Lock = GetLock ()

	-- which sector must be highlighted or "selected"?
    Selected = Selection (GetHovered ())

	-- Ready, set... draw!
	DrawSpheres ()
	DrawSectors ()
	DrawCircles ()
	--DrawGUI ()

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function Selection (hovered)
    local selected = {}
    if hovered then
        local sector = hovered
        selected[sector] = colour.yellow
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
                selected[link] = colour.magenta
            end
        end
    end
    if Start and End and not Path then
        Path = AStar (Start, End)
    end
    if Path then
        local N = #Path
        for i, C in ipairs (Path) do
            local k = (i - 1) / (N - 1)
            selected[C] = colour.black * (1 - k) + colour.white * (k)
        end
    end
    if Start then selected[Start] = colour.black end
    if End then selected[End] = colour.white end
	return selected
end

function UpdateTimers ()
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

