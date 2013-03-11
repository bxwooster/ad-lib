function Sphere (this)
    core.Sphere (this.tMat, this.colour, this.radius)
end

function Node (this)
    this.tMat = this.parent.tMat ^ this.rMat
end

function Camera (this)
    CameraPointer (this)
    CameraArrows (this)
    core.SetCamera (this.tMat)
end

function Orbitholder (this)
    local R1 = this.radius
    for _,orbit in ipairs (this.orbits) do
        local R2 = R1 + orbit.width
        local A = math.pi * 2 / table.getn(orbit.cells)
        for i,cell in ipairs (orbit.cells) do
            core.Segment (this.tMat, cell.colour,
                R1, R2, A, A * (world.turn.float + i), nil, 0)
        end
        R1 = R2
    end
end

function CameraPointer (this)
    local C = this.tMat.c.w.v3
    local V = core.ScreenRay (core.Pointer ())
    local lock = core.PlaneIntersection (C, V, vec3.z, vec3.zero)

    if KeyDown (KEY.P1) then
        this.lock = lock;
    elseif KeyHeld (KEY.P1) then
        local delta = this.lock - lock
        this.tMat = mat4.Movement (delta) ^ this.tMat
    end

    core.SetCamera (this.tMat)
end

function CameraArrows (this)
    local dist = dt * this.speed

    if (KeyHeld (KEY.Left)) then
        this.tMat = mat4.Movement (dist * vec3.left) ^ this.tMat
    end

    if (KeyHeld (KEY.Right)) then
        this.tMat = mat4.Movement (dist * vec3.right) ^ this.tMat
    end

    if (KeyHeld (KEY.Up)) then
        this.tMat = mat4.Movement (dist * vec3.back) ^ this.tMat
    end

    if (KeyHeld (KEY.Down)) then
        this.tMat = mat4.Movement (dist * vec3.forward) ^ this.tMat
    end
end

function Loop ()
    local newTime = core.Time ()
    dt = newTime - (time or 0)
    time = newTime

    --world.center.tMat = world.center.tMat ^ mat4.Rotation (vec3.z, 0.3 * dt)
    apply (Node, world.nodes)

    Camera (world.camera)

    core.PreSphere ()
    apply (Sphere, world.spheres)

    core.PreSegment ()
    apply (Orbitholder, world.orbitholders)
    --core.Segment (world.center.tMat, vec3.New(0,0,1), 4, 4.3, math.pi, 0.8, nil, 0)

    local left = world.turn.endTime - time
    if left > 0 then
        world.turn.float = world.turn.int - left / 2
    elseif (KeyDown (KEY.Space)) then
        world.turn.int = world.turn.int + 1
        world.turn.endTime = time + 2
    end

    if (KeyDown (KEY.L)) then REPL () end
    if (KeyDown (KEY.R)) then world = InitWorld () end
    if (KeyDown (KEY.Escape)) then core.Halt () end
end
