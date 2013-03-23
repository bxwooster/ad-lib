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
	DrawCircles ()
	DrawSectors ()
	--DrawGUI ()

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function UpdateTimers ()
    local newTime = core.Time ()
    Dt = newTime - (Time or 0)
    Time = newTime
end

function UpdateNode (N)
    N.tMat = N.parent.tMat ^ N.rMat
end

