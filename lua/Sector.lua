function PreSector ()
	local program = core.XE.gsector.program
	local Apos2d = core.XE.gsector.Apos2d
	local vbo = core.XE.vsector.vbo
    GL.DepthMask (GL.FALSE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Enable (GL.BLEND)
    GL.BlendFunc (GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
    GL.Enable (GL.STENCIL_TEST)
    GL.StencilFunc (GL.GREATER, 1, 1)
    GL.StencilOp (GL.KEEP, GL.KEEP, GL.REPLACE)
    GL.UseProgram (program)
    GL.BindBuffer (GL.ARRAY_BUFFER, vbo)
    -- these two guys need to be called after glBindBuffer
    GL.VertexAttribPointer (Apos2d, 2, GL.FLOAT, GL.FALSE, 0, nil)
    GL.EnableVertexAttribArray (Apos2d)
end

function Sector (tMat, colour, r1, r2, angsize, angle)
	local shader = core.XE.gsector
    local M = math.floor ((math.floor (core.XE.vsector.size / 6) - 1) *
		angsize / (2*math.pi) + 1)

	local transform = mat4.Rotated (tMat, vec3.z, angle)
    local mvp = core.XE.Sviewproj ^ transform

    GL.UniformMatrix4fv (shader.Umvp, 1, GL.FALSE, mvp.p)
    GL.Uniform1f (shader.Uangle, angsize / M)
    GL.Uniform1f (shader.UR1, r1)
    GL.Uniform1f (shader.UR2, r2)
    GL.Uniform3fv (shader.Ucolour, 1, colour.p)
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
