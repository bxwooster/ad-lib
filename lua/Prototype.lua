function GenerateCache ()
	local N = 2
	Cache = {}
	for i = 0, N do
		local size = 2 ^ (N - i)
		local D = 16
		local buffer, vertices = GenerateBuffer (size, vec3 (0, 0, 0), D)
		Cache[i+1] = {buffer = buffer, vertices = vertices}
	end
end

function Prototype ()
    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)
	GL.PolygonMode (GL.FRONT_AND_BACK, GL.LINE)

	if KeyDown (KEY.U) or not Cache then
		GenerateCache ()
	end
	
	for _,node in ipairs (Cache) do
		DrawBuffer (node.buffer, node.vertices)
	end
end
