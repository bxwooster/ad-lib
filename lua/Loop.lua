function Loop ()
	-- update Time, Dt
    DoTime ()

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

	-- Draw all the "spheres" (but each has an Earth texture ATM)
    core.PreSphere ()
    apply (DrawSphere, World.spheres)

	-- Draw all the sectors
	PreSector ()
    core.PreSector ()
    apply (DrawSector, World.sectors)

    if KeyDown (KEY.L) then REPL () end
    if KeyDown (KEY.R) then World = NewWorld () end
    if KeyDown (KEY.Escape) then core.Halt () end
end

function PreSector ()
	local program = core.XE.gsector.program
	local Apos2d = core.XE.gsector.Apos2d
	local vbo = core.XE.vsector.vbo
    GL.glDepthMask (GL.GL_FALSE)
    GL.glEnable (GL.GL_DEPTH_TEST)
    GL.glEnable (GL.GL_BLEND)
    GL.glBlendFunc (GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA)
    GL.glEnable (GL.GL_STENCIL_TEST)
    GL.glStencilFunc (GL.GL_GREATER, 1, 1)
    GL.glStencilOp (GL.GL_KEEP, GL.GL_KEEP, GL.GL_REPLACE)
    GL.glUseProgram (program)
    GL.glBindBuffer (GL.GL_ARRAY_BUFFER, vbo)
    -- these two guys need to be called after glBindBuffer
    GL.glVertexAttribPointer (Apos2d, 2, GL.GL_FLOAT, GL.GL_FALSE, 0, nil)
    GL.glEnableVertexAttribArray (Apos2d)
end

function GetLock ()
    local C = World.camera.tMat.c.w.v3
    local V = core.ScreenRay (core.Pointer ())
    return core.PlaneIntersection (C, V, vec3.z, vec3.zero)
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
