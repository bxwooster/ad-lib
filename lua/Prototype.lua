function LODSelect (observer, level, x, y)
	local size = 2 ^ level
	local D = 16
	local center = vec3 (x * size, y * size, 0)
	local buffer, vertices = PrototypeGenerateBuffer (size, center, D)
	table.insert (Cache, {buffer = buffer, vertices = vertices})
end

function GenerateCache ()
	Cache = {}
	local highest = 2
	LODSelect (vec3 (0, 0, 0), highest, 0, 0)
end

function PrototypeDrawBuffer (buffer, vertices)
	MCDrawBuffer (buffer, vertices, Sviewproj)
end

function PrototypeGenerateBuffer (size, center, D)
	local halfsize = vec3 (size / 2, size / 2, size / 2)

	local vol0 = center - halfsize
	local vol1 = center + halfsize

	local uniform = GMarching.uniform
    GL.Uniform1f (uniform.time, Time)
	GL.Uniform1i (uniform.noise, 1)
	GL.ActiveTexture (GL.TEXTURE0)
	GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
	GL.ActiveTexture (GL.TEXTURE1)
	GL.BindTexture (GL.TEXTURE_3D, TNoise[0])

    local program = GMarching.glsl.program
	MCGenerateBuffer (program, grid, vol0, vol1)
end

function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)
	GL.PolygonMode (GL.FRONT_AND_BACK, GL.LINE)

	if KeyDown (KEY.U) or not Cache then
		GenerateCache ()
	end
	
	for _,node in ipairs (Cache) do
		PrototypeDrawBuffer (node.buffer, node.vertices)
	end
end

do
	local function cb (program)
		strs = FFI.new ("char const * [2]")
		strs[0] = "position"
		strs[1] = "colour"
		GL.TransformFeedbackVaryings (program, 2, strs, GL.INTERLEAVED_ATTRIBS)
	end
	local function hot (null, file, text)
		GMarching = LoadShader (file, text, cb)
	end
	core.Pull ("glsl/marching-cubes.glts", hot)
end
