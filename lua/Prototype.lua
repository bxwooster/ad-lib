function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])
    GL.UseProgram (GRender.glsl.program)

	local uniform = GRender.uniform
	local grid = FFI.new ("int [3]")
	local D = 64
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
    local file = io.open ("data/noise_half_16cubed_mips_00.vol", "rb")
    local text = file:read ("*all")

	TNoise = GLI.NewTexture ()
end

VAO = GLI.NewVertexArray ()

BEdge = GLI.NewBuffer ()
GL.BindBuffer (GL.ARRAY_BUFFER, BEdge[0])
GL.BufferData (GL.ARRAY_BUFFER, 1280 * 4, core.edge_data (), GL.STATIC_DRAW)

TEdge = GLI.NewTexture ()
GL.BindTexture (GL.TEXTURE_BUFFER, TEdge[0])
GL.TexBuffer (GL.TEXTURE_BUFFER, 0x8D8E, BEdge[0])

