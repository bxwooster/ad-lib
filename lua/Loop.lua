function Sphere (this)
    core.Sphere (this.tmat, this.colour, this.radius)
end

function Node (this)
    this.tmat = core.mat4_multiply (this.rmat, this.parent.tmat)
end

function Orbitholder (this)
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / table.getn(orbit.cells)
        for i,cell in ipairs (orbit.cells) do
            core.Segment (this.tmat, cell.colour,
                R1, R2, A, time + A * i, nil, 0)
        end
        R1 = R2
    end
end

function Camera (this)
    local dist = dt * this.speed

    if (KeyHeld (KEY.Left)) then
        this.tmat:Move (dist * vec3.left)
    end

    if (KeyHeld (KEY.Right)) then
        this.tmat:Move (dist * vec3.right)
    end

    if (KeyHeld (KEY.Up)) then
        this.tmat:Move (dist * vec3.up)
    end

    if (KeyHeld (KEY.Down)) then
        this.tmat:Move (dist * vec3.down)
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

    --core.stone_frame_G ();
    --core.stone_frame_C ();

    if (KeyDown (KEY.Space)) then
        -- ;)
    end

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.R)) then world = InitWorld () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
