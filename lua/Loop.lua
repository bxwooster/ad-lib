function Sphere (this)
    core.Sphere (this.tmat, this.radius)
end

function Transform (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end

function Orbitholder (this)
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local a = math.pi * 2 / orbit.cells
        for i = 1, orbit.cells do
            core.Segment (this.tmat, R1, R2, a, a * i, nil, 0)
        end
        R1 = R2
    end
end

function Loop ()
    core.stone_frame_G ();
    --core.stone_frame_C ();

    apply (Transform, transforms)
    core.PreSphere ()
    apply (Sphere, spheres)

    core.PreSegment ()
    apply (Orbitholder, orbitholders)

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
