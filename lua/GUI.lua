function DrawGUI ()
    GL.DepthMask (GL.FALSE)
    GL.Disable (GL.DEPTH_TEST)
    GL.Enable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

    GL.UseProgram (GTest.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VRect.vbo)
	local Apos2d = GTest.attribute.Apos2d
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, NULL)
    GL.EnableVertexAttribArray (Apos2d)

	local CtoP = 64
	local halfScreenP = core.ScreenSize () / 2
	local multiplier = CtoP * vec2.Eldiv (vec2 (1, 1), halfScreenP)

	local TL = vec2.Eldiv (vec2 (-1, 1), multiplier)
	local TR = vec2.Eldiv (vec2 (1, 1), multiplier)
	local BR = vec2.Eldiv (vec2 (1, -1), multiplier)
	local BL = vec2.Eldiv (vec2 (-1, -1), multiplier)

	function DrawRect (c1, c2)
		local s1 = vec2.Elmul (c1, multiplier)
		local s2 = vec2.Elmul (c2, multiplier)

		local uniform = GTest.uniform
		GL.Uniform2fv (uniform.Us1, 1, s1.p)
		GL.Uniform2fv (uniform.Us2, 1, s2.p)
		GL.DrawArrays (GL.TRIANGLES, 0, VRect.size)
	end

	local c1 = BL + vec2 (2, 2) + vec2 (math.sin (Time), math.cos (Time))
	local c2 = c1 - vec2 (1, 1)
	DrawRect (c1, c2)
end


function GTestInit ()
	local function hot (null, file, text)
		GTest = LoadShader (file, text)
	end
	core.Pull ("glsl/test.glts", hot)
end

function VRectInit ()
	local function gc (V)
    	GL.DeleteBuffers (1, V.vbo);
	end
	VRect = FFI.gc (core.util_rect (), gc)
end

