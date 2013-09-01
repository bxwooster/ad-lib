if not Camera then
	Camera = DefaultCamera ()
	Camera.speed = 0.5
end

function Dach ()
	PrepareGL ()

	CameraArrows (Camera)
	UpdateCamera (Camera)
	PreSphere ()
	Sphere (mat4.id, vec4(1,1,1,1), 1.0)

    GL.UseProgram (GCube.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VCube.vbo)

	GL.EnableVertexAttribArray (GCube.attribute.pos)
	local offset = FFI.cast ("char *", 0)
	GL.VertexAttribPointer (GCube.attribute.pos, 4, GL.FLOAT,
		GL.FALSE, 12, offset)

	local uniform = GCube.uniform
	local mat = Sviewproj ^ mat4.Rotation (vec3 (1, 1, 1), Time)
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mat.p)

	GL.DrawArrays (GL.TRIANGLES, 0, VCube.size)
end

if not VCube then
	local function gc (V)
		ptr = FFI.new ("int [1]", V.vbo)
    	GL.DeleteBuffers (1, ptr);
	end
	VCube = FFI.gc (core.util_cube (), gc)
end

if not GCube then
	local function hot (null, file, text)
		GCube = LoadShader (file, text)
	end
	core.Pull ("glsl/render-cube.glts", hot)
end
