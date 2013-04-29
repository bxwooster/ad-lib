function PreCircle ()
    GL.DepthMask (GL.FALSE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Enable (GL.BLEND)
    GL.BlendFunc (GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    GL.Enable (GL.STENCIL_TEST)
    GL.StencilFunc (GL.GREATER, 1, 1)
    GL.StencilOp (GL.KEEP, GL.KEEP, GL.REPLACE)
    GL.UseProgram (GCircle.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VImposter.vbo)
    -- these two guys need to be called after glBindBuffer
	local Apos2d = GCircle.attribute.Apos2d
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, nil)
    GL.EnableVertexAttribArray (Apos2d)
end

function Circle (tMat, colour, r)
	local mvp = Sviewproj ^ tMat

	local uniform = GCircle.uniform
	GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
	GL.Uniform1f (uniform.UR, r)
	GL.Uniform3fv (uniform.Ucolour, 1, colour.p)

	GL.DrawArrays (GL.TRIANGLES, 0, VImposter.size)
end

function DrawCircle (C)
    Circle (C.tMat, C.colour, C.radius)
end

function DrawCircles ()
	PreCircle ()
	apply (DrawCircle, World.circles)
end

do
	local function hot (null, file, text)
		GCircle = LoadShader (file, text)
	end
	core.Pull ("glsl/circle.glts", hot)
end

