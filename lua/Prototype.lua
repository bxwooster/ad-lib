function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])
    GL.UseProgram (GRender.glsl.program)

	local uniform = GRender.uniform
	local grid = FFI.new ("int [2]")
	grid [0] = 5
	grid [1] = 5
	local mvp = Sviewproj ^ mat4.Movement (vec3 (-grid [0] / 2, -grid [1] /2, 0))
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
    GL.Uniform2iv (uniform.grid, 1, grid)
    GL.DrawArrays (GL.POINTS, 0, grid [0] * grid [1])
end

do
	local function hot (null, file, text)
		GRender = LoadShader (file, text)
	end
	core.Pull ("glsl/prototype.glts", hot)
end

do
	local function gc (V)
    	GL.DeleteBuffers (1, V.vbo);
	end
	VCube = FFI.gc (core.util_cube (), gc)
	VAO = FFI.new ("GLuint [1]")
	GL.GenVertexArrays (1, VAO)
end

