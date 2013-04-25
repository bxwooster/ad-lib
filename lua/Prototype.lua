function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])
    GL.UseProgram (GRender.glsl.program)

	local uniform = GRender.uniform
	local grid = FFI.new ("int [2]")
	grid [0] = 64
	grid [1] = 64
	local mvp = Sviewproj
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
    GL.Uniform2iv (uniform.grid, 1, grid)
    GL.Uniform1f (uniform.time, Time)
    GL.DrawArrays (GL.POINTS, 0, grid [0] * grid [1])
end

do
	local function hot (null, file, text)
		GRender = LoadShader (file, text)
	end
	core.Pull ("glsl/marching-squares.glts", hot)
end

do
	local function gc (V)
		local p = FFI.new ("GLuint [1]")
		p [0] = V.vbo
    	GL.DeleteBuffers (1, p);
	end
	VCube = FFI.gc (core.util_cube (), gc)
	VAO = FFI.new ("GLuint [1]")
	GL.GenVertexArrays (1, VAO)
end

