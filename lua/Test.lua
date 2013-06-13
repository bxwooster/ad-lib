print [[

	Controls:

	Arrow keys to move shadow
	Page Up/Down to control blur
	Home/End to control spread
	I to toggle inset

	A for method A, rectangle
	B for method B, concave
	C for method C, any

	1 for rectangle
	2 for circle
	3 for donut

	S to select spread type
	R to reload shader

	Esc to exit
]]

params = params or {
	type = 3,
	method = 'C',
	inset = false,
	offset = vec2 (65, 80),
	blur = 10,
	spread = 0,
	spread_method = false,
	object = vec2(512, 384),
	size = vec2(100, 100),
}

function Test ()
	if KeyDown(KEY.N1) then params.type = 1 end
	if KeyDown(KEY.N2) then params.type = 2 end
	if KeyDown(KEY.N3) then params.type = 3 end
	if KeyDown(KEY.A) then params.method = 'A' end
	if KeyDown(KEY.B) then params.method = 'B' end
	if KeyDown(KEY.C) then params.method = 'C' end
	if KeyDown(KEY.R) then ReloadShaders() end
	if KeyDown(KEY.I) then params.inset = not params.inset end
	if KeyDown(KEY.S) then params.spread_method = not params.spread_method end
	if KeyHeld(KEY.Left) then params.offset = params.offset + vec2 (-1, 0) end
	if KeyHeld(KEY.Right) then params.offset = params.offset + vec2 (1, 0) end
	if KeyHeld(KEY.Up) then params.offset  = params.offset + vec2 (0, -1) end
	if KeyHeld(KEY.Down) then params.offset = params.offset + vec2 (0, 1) end
	if KeyHeld(KEY.PageUp) then params.blur = params.blur + 1 end
	if KeyHeld(KEY.PageDown) then params.blur = math.max(params.blur - 1, 0) end
	if KeyHeld(KEY.Home) then params.spread = params.spread + 1 end
	if KeyHeld(KEY.End) then params.spread = params.spread - 1 end

    GL.DepthMask (GL.FALSE)
    GL.Disable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
	--GL.BlendFunc (GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    GL.Disable (GL.STENCIL_TEST)

	-- pass 0: draw objects.
	GL.BindFramebuffer (GL.FRAMEBUFFER, FScene[0])
    GL.ClearColor (1, 1, 1, 0);
    GL.Clear (GL.COLOR_BUFFER_BIT);
    GL.UseProgram (GRect.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VRect.vbo)
	local Apos2d = GRect.attribute.Apos2d
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, NULL)
    GL.EnableVertexAttribArray (Apos2d)

	function DrawRect (s1, s2)
		local uniform = GRect.uniform
		GL.Uniform2fv (uniform.resolution, 1, core.ScreenSize ().p)
		GL.Uniform2fv (uniform.s1, 1, s1.p)
		GL.Uniform2fv (uniform.s2, 1, s2.p)
		GL.Uniform1i (uniform.type, params.type)
		GL.DrawArrays (GL.TRIANGLES, 0, VRect.size)
	end

	local c = params.object
	local s = params.size
	DrawRect (c - s, c + s)

	local resolution = core.ScreenSize ()
	local spread_sign = not params.inset and 1 or -1

	local function pass (G)
		GL.UseProgram (G.glsl.program)
		GL.BindBuffer (GL.ARRAY_BUFFER, VRect.vbo)
		local Apos2d = G.attribute.Apos2d
		GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, NULL)
		GL.EnableVertexAttribArray (Apos2d)

		local uniform = G.uniform
		GL.Uniform2fv (uniform.resolution, 1, resolution.p)
		GL.Uniform2fv (uniform.object_pos, 1, params.object.p)
		GL.Uniform2fv (uniform.object_halfsize, 1, params.size.p)
		GL.Uniform2fv (uniform.offset, 1, params.offset.p)
		GL.Uniform1f (uniform.blur_radius, params.blur)
		GL.Uniform1f (uniform.spread, params.spread * spread_sign)
		GL.Uniform1i (uniform.inset, params.inset)
		GL.Uniform1i (uniform.spread_method, params.spread_method)
		GL.Uniform1i (uniform.scene, 0)
		GL.Uniform1i (uniform.buffer, 1)
		GL.Uniform1i (uniform.linear, 2)
		GL.DrawArrays (GL.TRIANGLES, 0, VRect.size)
	end

    GL.ActiveTexture (GL.TEXTURE0)
	GL.BindTexture (GL.TEXTURE_2D, TScene[0])

	GL.ActiveTexture (GL.TEXTURE2)
	GL.BindTexture (GL.TEXTURE_1D, T1D[0])

	if params.method == 'A' then
		GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
		pass (GTestA1)

	elseif params.method == 'B' then
		-- pass 1
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[0])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		pass (GTestB1)

		-- pass 2
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[1])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[0])
		pass (GTestB2)

		-- pass 3
		GL.BindFramebuffer (GL.FRAMEBUFFER, F1D[0])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[1])
		GL.Viewport (0, 0, resolution.e.y, 1)
		pass (GTestB3)
		GL.Viewport (0, 0, resolution.e.x, resolution.e.y)

		-- pass 4
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[0])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		pass (GTestB4)

		-- pass 5
		GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[0])
		pass (GTestB5)

	elseif params.method == 'C' then
		-- pass 1
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[0])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		pass (GTestC1)

		-- pass 2
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[1])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[0])
		pass (GTestC2)

		-- pass 3
		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[0])
		GL.ClearColor (0, 0, 0, 0);
		GL.Clear (GL.COLOR_BUFFER_BIT);
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[1])
		pass (GTestC3)

		-- pass 4
		GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
		GL.ActiveTexture (GL.TEXTURE1)
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[0])
		pass (GTestC4)
	end
end

do
	-- make a new framebuffer
	FScene = FFI.new ("GLuint [1]")
	GL.GenFramebuffers (1, FScene)

	local function gc (F)
		GL.DeleteFramebuffers (1, F)
	end
	FScene = FFI.gc (FScene, gc)

	-- make a new texture
	TScene = FFI.new ("GLuint [1]")
	GL.GenTextures (1, TScene)

	local function gc (T)
    	GL.DeleteTextures (1, T);
	end
	TScene = FFI.gc (TScene, gc)

	local screen = core.ScreenSize ()
	GL.BindTexture (GL.TEXTURE_2D, TScene[0])
	GL.TexImage2D (GL.TEXTURE_2D, 0, GL.RGBA, screen.e.x, screen.e.y,
		0, GL.RGBA, GL.UNSIGNED_BYTE, nil)

	GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST)
	GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST)

	GL.BindFramebuffer (GL.FRAMEBUFFER, FScene[0])
	GL.FramebufferTexture (GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, TScene[0], 0)
	
	GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
end

do
	-- make a new framebuffer
	F1D = FFI.new ("GLuint [1]")
	GL.GenFramebuffers (1, F1D)

	local function gc (F)
		GL.DeleteFramebuffers (1, F)
	end
	F1D = FFI.gc (F1D, gc)

	-- make a new texture
	T1D = FFI.new ("GLuint [1]")
	GL.GenTextures (1, T1D)

	local function gc (T)
    	GL.DeleteTextures (1, T);
	end
	T1D = FFI.gc (T1D, gc)

	local screen = core.ScreenSize ()
	GL.BindTexture (GL.TEXTURE_1D, T1D[0])
	GL.TexImage1D (GL.TEXTURE_1D, 0, GL.RG16I, screen.e.y,
		0, GL.RG_INTEGER, GL.UNSIGNED_BYTE, nil)

	GL.TexParameteri (GL.TEXTURE_1D, GL.TEXTURE_MAG_FILTER, GL.NEAREST)
	GL.TexParameteri (GL.TEXTURE_1D, GL.TEXTURE_MIN_FILTER, GL.NEAREST)

	GL.BindFramebuffer (GL.FRAMEBUFFER, F1D[0])
	GL.FramebufferTexture (GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, T1D[0], 0)
	
	GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
end

do
	-- make two new framebuffers
	FBuffer = FFI.new ("GLuint [2]")
	GL.GenFramebuffers (2, FBuffer)

	local function gc (F)
		GL.DeleteFramebuffers (2, F)
	end
	FBuffer = FFI.gc (FBuffer, gc)

	-- make two new textures
	TBuffer = FFI.new ("GLuint [2]")
	GL.GenTextures (2, TBuffer)

	local function gc (T)
    	GL.DeleteTextures (2, T);
	end
	TBuffer = FFI.gc (TBuffer, gc)

	local screen = core.ScreenSize ()

	for i = 0, 1 do
		GL.BindTexture (GL.TEXTURE_2D, TBuffer[i])
		GL.TexImage2D (GL.TEXTURE_2D, 0, GL.R8, screen.e.x, screen.e.y,
			0, GL.RED, GL.UNSIGNED_BYTE, nil)
		GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.NEAREST)
		GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.NEAREST)
		GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_BORDER)
		GL.TexParameteri (GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_BORDER)

		GL.BindFramebuffer (GL.FRAMEBUFFER, FBuffer[i])
		GL.FramebufferTexture (GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, TBuffer[i], 0)
	end

	GL.BindFramebuffer (GL.FRAMEBUFFER, 0)
end

do
	local function hot (null, file, text)
		GRect = LoadShader (file, text)
	end
	core.Pull ("glsl/rect.glts", hot)
end

function ReloadShaders()
	local function hot (null, file, text) GTestA1 = LoadShader (file, text) end
	core.Pull ("glsl/testA1.glts", hot)

	local function hot (null, file, text) GTestB1 = LoadShader (file, text) end
	core.Pull ("glsl/testB1.glts", hot)

	local function hot (null, file, text) GTestB2 = LoadShader (file, text) end
	core.Pull ("glsl/testB2.glts", hot)

	local function hot (null, file, text) GTestB3 = LoadShader (file, text) end
	core.Pull ("glsl/testB3.glts", hot)

	local function hot (null, file, text) GTestB4 = LoadShader (file, text) end
	core.Pull ("glsl/testB4.glts", hot)

	local function hot (null, file, text) GTestB5 = LoadShader (file, text) end
	core.Pull ("glsl/testB5.glts", hot)

	local function hot (null, file, text) GTestC1 = LoadShader (file, text) end
	core.Pull ("glsl/testC1.glts", hot)

	local function hot (null, file, text) GTestC2 = LoadShader (file, text) end
	core.Pull ("glsl/testC2.glts", hot)

	local function hot (null, file, text) GTestC3 = LoadShader (file, text) end
	core.Pull ("glsl/testC3.glts", hot)

	local function hot (null, file, text) GTestC4 = LoadShader (file, text) end
	core.Pull ("glsl/testC4.glts", hot)

	print "Loaded shaders!"
end

ReloadShaders()

do
	local function gc (V)
    	--GL.DeleteBuffers (1, V.vbo);
	end
	VRect = FFI.gc (core.util_rect (), gc)
end

