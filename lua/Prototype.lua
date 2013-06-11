function Gen ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])

	centers = {
		[0] = vec3 (-0.5, -0.5, 0),
		vec3 (-0.5, 0.5, 0),
		vec3 (0.5, 0.5, 0),
		vec3 ( 0.5, -0.5, 0)
	}

	for i = 0, 3 do
		First (i, centers[i])
	end
end

Dynamic = true
function Prototype ()
	if KeyDown (KEY.M) then
		Dynamic = not Dynamic
		if not Dynamic then Gen () end
	end
	if Dynamic then Gen () end
	for i = 0, 3 do
		Second (i)
	end
end

function First (I, center)
    GL.UseProgram (GMarching.glsl.program)

	local uniform = GMarching.uniform
	local grid = FFI.new ("int [3]")
	local D = Dynamic and 32 or 128
	grid [0] = D
	grid [1] = D
	grid [2] = D
	local total = grid[0] * grid[1] * grid[2]
	local size = 1
	local halfsize = vec3 (size / 2, size / 2, size / 2)
    GL.Uniform3iv (uniform.grid, 1, grid)
    GL.Uniform3fv (uniform.vol0, 1, (center - halfsize).p)
    GL.Uniform3fv (uniform.vol1, 1, (center + halfsize).p)
    GL.Uniform1f (uniform.time, Time)
	GL.Uniform1i (uniform.edges, 0)
	GL.Uniform1i (uniform.noise, 1)
	GL.ActiveTexture (GL.TEXTURE0)
	GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
	GL.ActiveTexture (GL.TEXTURE1)
	GL.BindTexture (GL.TEXTURE_3D, TNoise[0])
	GL.BindBufferBase (GL.TRANSFORM_FEEDBACK_BUFFER, 0, BFeedback[I])

	GL.BeginQuery (GL.TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, QFeedback[I])
	GL.Enable (GL.RASTERIZER_DISCARD)
	GL.BeginTransformFeedback (GL.TRIANGLES)
    GL.DrawArrays (GL.POINTS, 0, total)
	GL.EndTransformFeedback ()
	GL.Disable (GL.RASTERIZER_DISCARD)
	GL.EndQuery (GL.TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)
end

function Second (I)
	local uint = FFI.new ("uint32_t [1]")
	GL.GetQueryObjectuiv (QFeedback[I], GL.QUERY_RESULT, uint)

    GL.UseProgram (GRender.glsl.program)
	local uniform = GRender.uniform
	local mvp = Sviewproj
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
	GL.BindBuffer (GL.ARRAY_BUFFER, BFeedback[I])
	GL.EnableVertexAttribArray (GRender.attribute.pos)
	GL.EnableVertexAttribArray (GRender.attribute.normal)
	local offset = FFI.cast ("char *", 0)
	GL.VertexAttribPointer (GRender.attribute.pos, 4, GL.FLOAT,
		GL.FALSE, 28, offset)
	GL.VertexAttribPointer (GRender.attribute.normal, 3, GL.FLOAT,
		GL.FALSE, 28, offset + 16)

	GL.DrawArrays (GL.TRIANGLES, 0, 3 * uint[0])

	GL.DisableVertexAttribArray (GRender.attribute.pos)
	GL.DisableVertexAttribArray (GRender.attribute.normal)
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
do
	local function hot (null, file, text)
		GRender = LoadShader (file, text)
	end
	core.Pull ("glsl/render.glts", hot)
end

do
    local file = io.open ("data/noise_half_16cubed_mips_00.vol", "rb")
	local header = 20
	local size = 32768
    local text = file:read (header + size)
	local data = FFI.cast ("const char *", text) + header

	TNoise = GLI.NewTexture ()
	GL.BindTexture (GL.TEXTURE_3D, TNoise[0])
	GL.TexImage3D (GL.TEXTURE_3D, 0, GL.RGBA, 16, 16, 16, 0,
		GL.RGBA, GL.HALF_FLOAT, data)
	GL.TexParameteri (GL.TEXTURE_3D, GL.TEXTURE_BASE_LEVEL, 0)
	GL.TexParameteri (GL.TEXTURE_3D, GL.TEXTURE_MAX_LEVEL, 0)
end

VAO = GLI.NewVertexArray ()

BEdge = GLI.NewBuffer ()
GL.BindBuffer (GL.ARRAY_BUFFER, BEdge[0])
GL.BufferData (GL.ARRAY_BUFFER, 1280 * 4, core.edge_data (), GL.STATIC_DRAW)

BFeedback = GLI.NewBuffer (4)
for i = 0, 3 do
	GL.BindBuffer (GL.ARRAY_BUFFER, BFeedback[i])
	GL.BufferData (GL.ARRAY_BUFFER, 2^25, nil, GL.STREAM_DRAW)
end
QFeedback = GLI.NewQuery (4)

TEdge = GLI.NewTexture ()
GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
GL.TexBuffer (GL.TEXTURE_BUFFER, GL.RGBA8I, BEdge[0])
