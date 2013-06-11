function LODSelect (observer, level, x, y)
	local size = 2 ^ level
	local D = 16
	local center = vec3 (x * size, y * size, 0)
	local buffer, vertices = GenerateBuffer (size, center, D)
	table.insert (Cache, {buffer = buffer, vertices = vertices})
end

function GenerateCache ()
	Cache = {}
	local highest = 2
	LODSelect (vec3 (0, 0, 0), highest, 0, 0)
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
