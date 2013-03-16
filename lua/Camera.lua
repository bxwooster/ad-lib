function UpdateCamera (C)
    core.SetCamera (C.tMat)
    CameraPointer (C)
    CameraArrows (C)
end

function CameraPointer (C)
    if KeyDown (KEY.P1) then
        C.lock = Lock;
    elseif KeyHeld (KEY.P1) then
        local delta = C.lock - Lock
        C.tMat = mat4.Movement (delta) ^ C.tMat
    else
        C.lock = nil
    end
end

function CameraArrows (C)
    local dist = Dt * C.speed

    if KeyHeld (KEY.Left) then
        C.tMat = mat4.Movement (dist * vec3.left) ^ C.tMat
    end

    if KeyHeld (KEY.Right) then
        C.tMat = mat4.Movement (dist * vec3.right) ^ C.tMat
    end

    if KeyHeld (KEY.Up) then
        C.tMat = mat4.Movement (dist * vec3.back) ^ C.tMat
    end

    if KeyHeld (KEY.Down) then
        C.tMat = mat4.Movement (dist * vec3.forward) ^ C.tMat
    end
end
