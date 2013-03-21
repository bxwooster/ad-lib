function PreSector ()
    GL.DepthMask (GL.FALSE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Enable (GL.BLEND)
    GL.BlendFunc (GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    GL.Enable (GL.STENCIL_TEST)
    GL.StencilFunc (GL.GREATER, 1, 1)
    GL.StencilOp (GL.KEEP, GL.KEEP, GL.REPLACE)
    GL.UseProgram (GSector.glsl.program)
    GL.BindBuffer (GL.ARRAY_BUFFER, VSector.vbo)
    -- these two guys need to be called after glBindBuffer
	local Apos2d = GSector.attribute.Apos2d
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, nil)
    GL.EnableVertexAttribArray (Apos2d)
end

function Sector (tMat, colour, r1, r2, angsize, angle)
    local M = math.floor ((math.floor (VSector.size / 6) - 1) *
		angsize / (2*math.pi) + 1)

	local transform = mat4.Rotated (tMat, vec3.z, angle)
    local mvp = Sviewproj ^ transform

	local uniform = GSector.uniform
    GL.UniformMatrix4fv (uniform.Umvp, 1, GL.FALSE, mvp.p)
    GL.Uniform1f (uniform.Uangle, angsize / M)
    GL.Uniform1f (uniform.UR1, r1)
    GL.Uniform1f (uniform.UR2, r2)
    GL.Uniform3fv (uniform.Ucolour, 1, colour.p)
    GL.DrawArrays (GL.TRIANGLES, 0, M * 6)
end

function DrawSector (S)
    local colour = Selected[S] or S.colour
    Sector (S.parent.tMat, colour,
        S.parent.R1, S.parent.R2, S.parent.A, S.B)
end

function DrawSectors ()
	PreSector ()
	apply (DrawSector, World.sectors)
end

function GSectorInit ()
	local function hot (null, file, text)
		GSector = LoadShader (file, text)
	end
	core.Pull ("glsl/sector.glts", hot)
end

function VSectorInit ()
	local function gc (V)
    	GL.DeleteBuffers (1, V.vbo);
	end
	VSector = FFI.gc (core.util_sector (), gc)
end
