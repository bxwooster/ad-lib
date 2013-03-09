function Sphere (this)
    core.Sphere (this.tmat, this.radius)
end

function Node (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end

function Orbitholder (this)
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / orbit.cells
        for i = 1, orbit.cells do
            core.Segment (this.tmat, R1, R2, A, time + A * i, nil, 0)
        end
        R1 = R2
    end
end

function Camera (this)
    if (KeyDown (KEY.Left)) then
        this.tmat = core.mat4_multiply (this.tmat,
            mat4.Movement (vec3.left))
    end

    if (KeyDown (KEY.Right)) then
        this.tmat = core.mat4_multiply (this.tmat,
            mat4.Movement (vec3.right))
    end

    core.SetCamera (world.camera.tmat)
end

function Loop ()
    time = core.Time ()
    dt = core.Dt ()

    apply (Node, world.nodes)

    Camera (world.camera)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Orbitholder, world.orbitholders)

    core.stone_frame_G ();
    --core.stone_frame_C ();
    
    if (KeyDown (KEY.Space)) then
        -- ;)
    end

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
