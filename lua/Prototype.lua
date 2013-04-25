function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])
    GL.UseProgram (GRender.glsl.program)

	local uniform = GRender.uniform
	local grid = FFI.new ("int [3]")
	local D = 16
	grid [0] = D
	grid [1] = D
	grid [2] = D
	local mvp = Sviewproj
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
    GL.Uniform3iv (uniform.grid, 1, grid)
    GL.Uniform1f (uniform.time, Time)
	GL.Uniform1i (uniform.edges, 0)
	GL.ActiveTexture (GL.TEXTURE0)
	GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
    GL.DrawArrays (GL.POINTS, 0, grid[0] * grid[1] * grid[2])
end
do
	local function hot (null, file, text)
		GRender = LoadShader (file, text)
	end
	core.Pull ("glsl/marching-cubes.glts", hot)
end

do
	local function gc (V)
		GL.DeleteVertexArrays (1, V)
	end
	VAO = FFI.gc (FFI.new ("GLuint [1]"), gc)
	GL.GenVertexArrays (1, VAO)
end

do
	local function gc (B)
		GL.DeleteBuffers (1, B)
	end
	BEdge = FFI.gc (FFI.new ("GLuint [1]"), gc)
	GL.GenBuffers (1, BEdge)
	GL.BindBuffer (GL.ARRAY_BUFFER, BEdge[0])
	GL.BufferData (GL.ARRAY_BUFFER, 1280 * 4, core.edge_data (), GL.STATIC_DRAW)
end

do
	local function gc (T)
		GL.DeleteTextures (1, T)
	end
	TEdge = FFI.gc (FFI.new ("GLuint [1]"), gc)
	GL.GenTextures (1, TEdge)
	GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
	GL.TexBuffer (GL.TEXTURE_BUFFER, 0x8D8E, BEdge[0])
end

