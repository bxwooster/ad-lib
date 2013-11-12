Ft = FFI.load "freetype"

function Five ()
    GL.DepthMask (GL.FALSE)
    GL.Disable (GL.DEPTH_TEST)
    GL.Enable (GL.BLEND)
    GL.BlendFunc (GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    GL.Disable (GL.STENCIL_TEST)
    GL.Clear (GL.COLOR_BUFFER_BIT)

    GL.UseProgram (GTest.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VRect.vbo)

	local Apos2d = GTest.attribute.Apos2d
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, NULL)
    GL.EnableVertexAttribArray (Apos2d)

	local halfScreenP = core.ScreenSize () / 2
	local multiplier = vec2.Eldiv (vec2 (1, 1), halfScreenP)

	local function RoundedRect (c1, c2, color)
		local s1 = vec2.Elmul (c1, multiplier)
		local s2 = vec2.Elmul (c2, multiplier)

		local uniform = GTest.uniform
		GL.Uniform1f (uniform.T, 0.2)
		GL.Uniform4fv (uniform.color, 1, color.p)
		GL.Uniform2fv (uniform.Us1, 1, s1.p)
		GL.Uniform2fv (uniform.Us2, 1, s2.p)
		GL.DrawArrays (GL.TRIANGLES, 0, VRect.size)
	end

	for i = 0, 10 do
		local a = i / 10.0
		local color = vec4 (0.2, 0.4, 0.8, a)
		local vec = vec2(256,256) + vec2(-10*i, -10*i)
		RoundedRect (-vec, vec, color)
	end
end

GTest = GetShader ("glsl/test.glts")
VRect = WrapVBO (core.util_rect ())
