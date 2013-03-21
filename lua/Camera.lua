FOV = 60 -- yes, just like that

function UpdateCamera (C)
    CameraPointer (C)
    CameraArrows (C)
    SetCamera (C.tMat)
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

function SetCamera (mCam)
	local size = core.ScreenSize ()
    Sproj = core.util_projection (size.e.x, size.e.y, FOV);
    Sviewi = mCam
    Sviewproj = Sproj ^ mat4.Inverse (mCam)
end
