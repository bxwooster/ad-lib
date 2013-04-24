function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

	GL.BindVertexArray (VAO[0])

    GL.UseProgram (GRender.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VCube.vbo)
    -- these two guys need to be called after GL.BindBuffer
	local Apos = GRender.attribute.Apos
	CheckGL ()
    GL.VertexAttribPointer (Apos, 3, GL.FLOAT, GL.FALSE, 0, NULL)
    GL.EnableVertexAttribArray (Apos)

	local uniform = GRender.uniform
	local mvp = Sviewproj
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
    GL.DrawArrays (GL.TRIANGLES, 0, VCube.size)
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

