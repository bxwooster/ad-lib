function Sphere (this)
    core.Sphere (this.tmat, this.radius)
end

function Transform (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end

function Loop ()
    core.stone_frame_G ();
    core.stone_frame_C ();

    apply (Transform, transforms)
    core.PreSphere ()
    apply (Sphere, spheres)

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
