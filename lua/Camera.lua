function UpdateCamera (this)
    core.SetCamera (this.tMat)
    CameraPointer (this)
    CameraArrows (this)
end

function CameraPointer (this)
    local C = this.tMat.c.w.v3
    local V = core.ScreenRay (core.Pointer ())
    Lock = core.PlaneIntersection (C, V, vec3.z, vec3.zero)

    if KeyDown (KEY.P1) then
        this.lock = Lock;
    elseif KeyHeld (KEY.P1) then
        local delta = this.lock - Lock
        this.tMat = mat4.Movement (delta) ^ this.tMat
    else
        this.lock = nil
    end
end

function CameraArrows (this)
    local dist = Dt * this.speed

    if KeyHeld (KEY.Left) then
        this.tMat = mat4.Movement (dist * vec3.left) ^ this.tMat
    end

    if KeyHeld (KEY.Right) then
        this.tMat = mat4.Movement (dist * vec3.right) ^ this.tMat
    end

    if KeyHeld (KEY.Up) then
        this.tMat = mat4.Movement (dist * vec3.back) ^ this.tMat
    end

    if KeyHeld (KEY.Down) then
        this.tMat = mat4.Movement (dist * vec3.forward) ^ this.tMat
    end
end
