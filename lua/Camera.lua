function UpdateCamera (this)
    Core.SetCamera (this.tMat)
    CameraPointer (this)
    CameraArrows (this)
end

function CameraPointer (this)
    local C = this.tMat.c.w.v3
    local V = Core.ScreenRay (Core.Pointer ())
    Lock = Core.PlaneIntersection (C, V, Vec3.z, Vec3.zero)

    if KeyDown (KEY.P1) then
        this.lock = Lock;
    elseif KeyHeld (KEY.P1) then
        local delta = this.lock - Lock
        this.tMat = Mat4.Movement (delta) ^ this.tMat
    else
        this.lock = nil
    end
end

function CameraArrows (this)
    local dist = Dt * this.speed

    if KeyHeld (KEY.Left) then
        this.tMat = Mat4.Movement (dist * Vec3.left) ^ this.tMat
    end

    if KeyHeld (KEY.Right) then
        this.tMat = Mat4.Movement (dist * Vec3.right) ^ this.tMat
    end

    if KeyHeld (KEY.Up) then
        this.tMat = Mat4.Movement (dist * Vec3.back) ^ this.tMat
    end

    if KeyHeld (KEY.Down) then
        this.tMat = Mat4.Movement (dist * Vec3.forward) ^ this.tMat
    end
end
