function PrepareGL ()
	CheckGL ()
	local size = core.ScreenSize ()
    GL.Viewport (0, 0, size.e.x, size.e.y)
    GL.DepthMask (GL.TRUE);
    GL.ClearColor (0, 0, 0, 0);
    GL.ClearStencil (0);
	local flags = BIT.bor (GL.COLOR_BUFFER_BIT,
						   GL.DEPTH_BUFFER_BIT,
						   GL.STENCIL_BUFFER_BIT)
    GL.Clear (flags);
end

function CheckGL ()
    local E = GL.GetError ();
	if E ~= 0 then
        print ("There occurred a GL error, # " .. tostring (E) .. ".");
	end
end

local function gc (G)
	GL.DeleteProgram (G.program)
end
function LoadShader (file, text, cb)
	local glsl = FFI.gc (core.glts_load (file, text, cb), gc)

	local function ai (t, k)
		local v = rawget (t, k)
		if not v then
			v = GL.GetAttribLocation (glsl.program, k);
			t[k] = v
		end
		return v
	end

	local function ui (t, k)
		local v = rawget (t, k)
		if not v then
			v = GL.GetUniformLocation (glsl.program, k)
			rawset (t, k, v)
		end
		return v
	end

	-- experimantal ;)
	--[[
	local vec2type = FFI.typeof (vec2.zero)
	local vec3type = FFI.typeof (vec3.zero)
	local vec4type = FFI.typeof (vec4.zero)
	local mat4type = FFI.typeof (mat4.id)
	local function un (t, k, data)
		local v = ui (t, k)
		if type (data) == "number" then
			GL.Uniform1f (v, data)
		elseif FFI.typeof (data) == vec2type then
			GL.Uniform2fv (v, 1, data.p)
		elseif FFI.typeof (data) == vec3type then
			GL.Uniform3fv (v, 1, data.p)
		elseif FFI.typeof (data) == vec4type then
			GL.Uniform4fv (v, 1, data.p)
		elseif FFI.typeof (data) == mat4type then
			GL.UniformMatrix4fv (v, 1, GL.FALSE, data.p)
		else
			error ("While setting uniform " .. k .. ": " .. tostring (data))
		end
	end
	--]]
	local un = nil

	attribute = setmetatable ({}, {__index = ai})
	uniform = setmetatable ({}, {__index = ui, __newindex = un})
	return {
		glsl = glsl,
		attribute = attribute,
		uniform = uniform,
	}
end

local shader_cache = {}
function GetShader (file)
	cached = shader_cache[file]
	if cached then
		return cached
	else
		local function hot (null, cfile, text)
			file = FFI.string (cfile)
			existing = shader_cache[file]
			new = LoadShader (file, text)
			if existing == nil then
				shader_cache[file] = new
			else
				existing.glsl = new.glsl
				existing.uniform = new.uniform
				existing.attribute = new.attribute
			end
		end
		core.Pull (file, hot)
		return shader_cache[file]
	end
end

function WrapVBO (util_vbo)
	local function gc (V)
		ptr = FFI.new ("int [1]", V.vbo)
    	GL.DeleteBuffers (1, ptr);
	end
	return FFI.gc (util_vbo, gc)
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
