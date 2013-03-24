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

	if KeyHeld (KEY.P2) then
		local delta = C.ptr - core.Pointer ()
		C.tMat = mat4.Rotation (vec3.z, delta.e.x) ^ C.tMat
		C.tMat = mat4.Rotation (vec3.x, delta.e.y) ^ C.tMat
	end
	C.ptr = core.Pointer ()
end

function CameraArrows (C)
    local dist = Dt * C.speed

    if KeyHeld (KEY.Left) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.left)
    end

    if KeyHeld (KEY.Right) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.right)
    end

    if KeyHeld (KEY.Up) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.back)
    end

    if KeyHeld (KEY.Down) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.forward)
    end

    if KeyHeld (KEY.PageUp) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.up)
    end

    if KeyHeld (KEY.PageDown) then
        C.tMat = C.tMat ^ mat4.Movement (dist * vec3.down)
    end
end

function SetCamera (mCam)
	local size = core.ScreenSize ()
    Sproj = core.util_projection (size.e.x, size.e.y, FOV);
    Sviewi = mCam
    Sviewproj = Sproj ^ mat4.Inverse (mCam)
end
