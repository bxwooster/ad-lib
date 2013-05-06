function GenerateCache ()
	local N = 2
	Cache = {}
	for i = 0, N do
		local size = 2 ^ (N - i)
		local buffer, vertices = GenerateBuffer (size, vec3 (0, 0, 0))
		Cache[i+1] = {buffer = buffer, vertices = vertices}
	end
end

if Dynamic == nil then Dynamic = true end

function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)
	GL.PolygonMode (GL.FRONT_AND_BACK, GL.LINE)

	GL.BindVertexArray (VAO[0])

	if KeyDown (KEY.M) then
		Dynamic = not Dynamic
		if not Dynamic then GenerateCache () end
	end
	if Dynamic then GenerateCache () end
	for _,node in ipairs (Cache) do
		DrawBuffer (node.buffer, node.vertices)
	end
end
