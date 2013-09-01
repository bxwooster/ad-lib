function MCGenerateBuffer (shader, D, vol0, vol1)
	local grid = FFI.new ("int [3]")
	grid [0] = D
	grid [1] = D
	grid [2] = D
	local total = grid[0] * grid[1] * grid[2]

    GL.UseProgram (shader.glsl.program)
	local uniform = shader.uniform
    GL.Uniform3iv (uniform.grid, 1, grid)
    GL.Uniform3fv (uniform.vol0, 1, vol0.p)
    GL.Uniform3fv (uniform.vol1, 1, vol1.p)
	GL.Uniform1i (uniform.edges, 0)

	GL.BindBufferBase (GL.TRANSFORM_FEEDBACK_BUFFER, 0, BFeedback[0])

	GL.BeginQuery (GL.TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, QFeedback[0])
	GL.Enable (GL.RASTERIZER_DISCARD)
	GL.BeginTransformFeedback (GL.TRIANGLES)
    GL.DrawArrays (GL.POINTS, 0, total)
	GL.EndTransformFeedback ()
	GL.Disable (GL.RASTERIZER_DISCARD)
	GL.EndQuery (GL.TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN)

	local uint = FFI.new ("uint32_t [1]")
	GL.GetQueryObjectuiv (QFeedback[0], GL.QUERY_RESULT, uint)

	local out = GLI.NewBuffer ()
	local sz = uint[0] * 3 * 28
	GL.BindBuffer (GL.COPY_READ_BUFFER, BFeedback[0])
	GL.BindBuffer (GL.ARRAY_BUFFER, out[0])
	GL.BufferData (GL.ARRAY_BUFFER, sz, nil, GL.STATIC_COPY)
	GL.CopyBufferSubData (GL.COPY_READ_BUFFER, GL.ARRAY_BUFFER, 0, 0, sz)

	return out, 3 * uint[0]
end

function MCDrawBuffer (buffer, vertices, mvp)
    GL.UseProgram (GRender.glsl.program)
	local uniform = GRender.uniform
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
	GL.Uniform1f (uniform.Uoffset, 0)
	GL.BindBuffer (GL.ARRAY_BUFFER, buffer[0])
	GL.EnableVertexAttribArray (GRender.attribute.pos)
	GL.EnableVertexAttribArray (GRender.attribute.normal)
	local offset = FFI.cast ("char *", 0)
	GL.VertexAttribPointer (GRender.attribute.pos, 4, GL.FLOAT,
		GL.FALSE, 28, offset)
	GL.VertexAttribPointer (GRender.attribute.normal, 3, GL.FLOAT,
		GL.FALSE, 28, offset + 16)

	GL.DrawArrays (GL.TRIANGLES, 0, vertices)

	GL.DisableVertexAttribArray (GRender.attribute.pos)
	GL.DisableVertexAttribArray (GRender.attribute.normal)
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

if BEdge then return end --hack to prevent re-creation of resources on reload

BEdge = GLI.NewBuffer ()
GL.BindBuffer (GL.ARRAY_BUFFER, BEdge[0])
GL.BufferData (GL.ARRAY_BUFFER, 1280 * 4, core.edge_data (), GL.STATIC_DRAW)

TEdge = GLI.NewTexture ()
GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
GL.TexBuffer (GL.TEXTURE_BUFFER, GL.RGBA8I, BEdge[0])

QFeedback = GLI.NewQuery ()
BFeedback = GLI.NewBuffer ()
GL.BindBuffer (GL.ARRAY_BUFFER, BFeedback[0])
-- warning: size is arbitrary, must be large enough
GL.BufferData (GL.ARRAY_BUFFER, 2^25, nil, GL.STREAM_DRAW)
