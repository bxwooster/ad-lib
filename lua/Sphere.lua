function DrawSphere (S)
    core.Sphere (S.tMat, S.colour, S.radius)
end

function DrawSpheres ()
    PreSphere ()
    apply (DrawSphere, World.spheres)
end

function PreSphere ()
	local shader = core.XE.gplanets[0]

    GL.DepthMask (GL.TRUE)
    GL.Enable (GL.DEPTH_TEST)
    GL.Disable (GL.BLEND)
    GL.Disable (GL.STENCIL_TEST)

    GL.UseProgram (shader.program)

    GL.BindBuffer (GL.ARRAY_BUFFER, core.XE.vimposter.vbo)
    -- these two guys need to be called after GL.BindBuffer
    GL.VertexAttribPointer (shader.Apos2d, 2, GL.FLOAT, GL.FALSE, 0, NULL)
    GL.EnableVertexAttribArray (shader.Apos2d)

    -- kind of hacky...
    GL.ActiveTexture (GL.TEXTURE0)
end
