if not Camera then
	Camera = DefaultCamera ()
	Camera.speed = 0.5
end

function Dach ()
	PrepareGL ()

	CameraArrows (Camera)
	UpdateCamera (Camera)

	GL.Enable (GL.DEPTH_TEST);
    GL.UseProgram (GCube.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VCube.vbo)

	GL.EnableVertexAttribArray (GCube.attribute.pos)
	local offset = FFI.cast ("char *", 0)
	GL.VertexAttribPointer (GCube.attribute.pos, 4, GL.FLOAT,
		GL.FALSE, 12, offset)

	local uniform = GCube.uniform
	local mat = Sviewproj ^ mat4.Rotation (vec3 (1, 1, 1), Time)
	local mat2 = Sviewproj ^ mat4.Rotation (vec3 (Time/100, 1, 1), Time)
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mat.p)

	--GL.DrawArrays (GL.TRIANGLES, 0, VCube.size)

	NO_GL_WARNINGS = 1
	local uniform = GMarching.uniform
	GL.UseProgram (GMarching.glsl.program)
	GL.Uniform1f (uniform.time, Time)
	buffer, vertices =
		MCGenerateBuffer (GMarching, 32, vec3 (-1,-1,-1), vec3(1,1,1))

	MCDrawBuffer (buffer, vertices, mat2)
	NO_GL_WARNINGS = 0
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

if not GMarching then
	local function cb (program)
		strs = FFI.new ("char const * [2]")
		strs[0] = "position"
		strs[1] = "colour"
		GL.TransformFeedbackVaryings (program, 2, strs, GL.INTERLEAVED_ATTRIBS)
	end
	local main_shader = "glsl/marching-cubes.glts"
	local function hot (null, file, text)
		GMarching = LoadShader (file, text, cb)
	end
	local function metahot (null, file, text)
		core.Pull (main_shader, hot)
	end
	core.Pull ("glsl/mc-new.glsl", metahot)
end
