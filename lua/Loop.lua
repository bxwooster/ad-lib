function Sphere (this)
    core.Sphere (this.tmat, this.colour, this.radius)
end

function Node (this)
    this.tmat = this.rmat ^ this.parent.tmat
end

function Camera (this)
    CameraPointer (this)
    CameraArrows (this)
    core.SetCamera (world.camera.tmat)
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

function CameraPointer (this)
    local C = this.tmat.c.w.v3
    local V = core.ScreenRay (core.Pointer ())
    local lock = core.PlaneIntersection (C, V, vec3.z, vec3.zero)

    if KeyDown (KEY.P1) then
        this.lock = lock;
    elseif KeyHeld (KEY.P1) then
        local delta = this.lock - lock
        this.tmat = mat4.Movement (delta) ^ this.tmat
    end

    core.SetCamera (this.tmat)
end

function CameraArrows (this)
    local dist = dt * this.speed

    if (KeyHeld (KEY.Left)) then
        this.tmat = mat4.Movement (dist * vec3.left) ^ this.tmat
    end

    if (KeyHeld (KEY.Right)) then
        this.tmat = mat4.Movement (dist * vec3.right) ^ this.tmat
    end

    if (KeyHeld (KEY.Up)) then
        this.tmat = mat4.Movement (dist * vec3.back) ^ this.tmat
    end

    if (KeyHeld (KEY.Down)) then
        this.tmat = mat4.Movement (dist * vec3.forward) ^ this.tmat
    end
end

function Loop ()
    local newTime = core.Time ()
    dt = newTime - (time or 0)
    time = newTime

    apply (Node, world.nodes)

    Camera (world.camera)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Orbitholder, world.orbitholders)

    if (KeyDown (KEY.Space)) then
        -- ;)
    end

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.R)) then world = InitWorld () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
