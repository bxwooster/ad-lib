function Loop ()
	PrepareGL ()

    UpdateTimers ()

	-- Update World.turn
    DoTurn ()

	-- update rings. Must be done before nodes
    apply (UpdateRing, World.rings)

	-- update nodes of the 3D transform hierarchy
    apply (UpdateNode, World.nodes)

    UpdateCamera (World.camera)

	-- where is the pointer hovering on the 2D ground plane?
	Lock = GetLock ()

	-- which sector must be highlighted or "selected"?
    Selected = Selection (GetHovered ())

	-- Ready, set... draw!
	--DrawSpheres ()
	--DrawCircles ()
	--DrawSectors ()
	--DrawGUI ()

	Prototype ()

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

function Attach (N1, N2)
	N1.rMat = mat4.Inverse (N2.tMat) ^ N1.tMat
	N1.parent = N2
end

function Test (i)
	Attach (World.camera, World.systems[3].rings[i])
	table.insert (World.nodes, World.camera)
end
