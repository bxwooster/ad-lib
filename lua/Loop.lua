function Sphere (this)
    core.Sphere (this.tmat, this.radius)
end

function Transform (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end

function Loop ()
    core.stone_frame_G ();
    --core.stone_frame_C ();

    apply (Transform, transforms)
    core.PreSphere ()
    apply (Sphere, spheres)

    core.PreSegment ()
    core.Segment (spheres[1].tmat, 0, 1, 1, 0, vec3.New (0, 0, 0), 0)

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
