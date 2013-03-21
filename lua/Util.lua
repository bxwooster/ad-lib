function PrepareGL ()
	local size = core.ScreenSize ()
    GL.Viewport (0, 0, size.e.x, size.e.y)
    GL.DepthMask (GL.TRUE);
    GL.ClearColor (0, 0, 0, 0);
    GL.ClearStencil (0);
	local flags = BIT.bor (GL.COLOR_BUFFER_BIT,
						   GL.DEPTH_BUFFER_BIT,
						   GL.STENCIL_BUFFER_BIT)
    GL.Clear (flags);

    local E = GL.GetError ();
	if E ~= 0 then
        print ("There occurred a GL error, # " .. tostring (E) .. ".");
	end
end

function PlaneIntersection (C, V, N, P)
    local ratio = - (N .. (C - P)) / (N .. V)
	return C + V * ratio
end

function ScreenRay (pointer)
    local q = 1 / math.tan (math.pi * FOV / 180 / 2);
    local screen = vec4 (pointer.e.x / q, -pointer.e.y / q, 1, 0)
    return (Sviewi % screen).v3;
end

function GetLock ()
    local C = World.camera.tMat.c.w.v3
    local V = ScreenRay (core.Pointer ())
    return PlaneIntersection (C, V, vec3.z, vec3.zero)
end

function KeyDown (key)
    return (core.Key (key) > 1)
end

function KeyHeld (key)
    return (core.Key (key) > 0)
end

function REPL ()
    local line
    while true do
        io.write ">>> "
        line = io.read ()
        if line == "exit" then
            break
        end
        local chunk, err = loadstring ("print(" .. line .. ")", ">>>")
        if chunk then
            local ok, result = pcall (chunk)
            if not ok then
                print (result)
            end
        elseif result then
            print (result)
        end
    end
end
