FOV = 60 -- yes, just like that

function DefaultCamera ()
	return {
        speed = 0.1,
        cMov = mat4.Movement (vec3 (0.0, 0.7, 0.1)),
		cYaw = mat4.id,
		cPitch = mat4.Rotation (vec3.x, 0.5 * math.pi),
    }
end

function UpdateCamera (C)
    CameraPointer (C)
    CameraArrows (C)
	C.tMat = C.cMov ^ C.cYaw ^ C.cPitch
    SetCamera (C.tMat)
end

function CameraPointer (C)
    if KeyDown (KEY.P1) then
        C.lock = Lock;
    elseif KeyHeld (KEY.P1) then
        local delta = C.lock - Lock
        C.cMov = mat4.Movement (delta) ^ C.cMov
    else
        C.lock = nil
    end

	if KeyHeld (KEY.P2) then
		local delta = C.ptr - core.Pointer ()
		C.cYaw = mat4.Rotation (vec3.z, delta.e.x) ^ C.cYaw
		C.cPitch = mat4.Rotation (vec3.x, delta.e.y) ^ C.cPitch
	end
	C.ptr = core.Pointer ()
end

function CameraArrows (C)
    local dist = Dt * C.speed
	--if KeyHeld (KEY.Shift) then dist = dist * 5 end

    if KeyHeld (KEY.Up) or KeyHeld (KEY.W) then
        C.cMov = C.cMov ^ mat4.Movement (C.cYaw % (dist * vec3.back))
    end

    if KeyHeld (KEY.Down) or KeyHeld (KEY.S) then
        C.cMov = C.cMov ^ mat4.Movement (C.cYaw % (dist * vec3.forward))
    end

    if KeyHeld (KEY.Left) or KeyHeld (KEY.A) then
        C.cMov = C.cMov ^ mat4.Movement (C.cYaw % (dist * vec3.left))
    end

    if KeyHeld (KEY.Right) or KeyHeld (KEY.D) then
        C.cMov = C.cMov ^ mat4.Movement (C.cYaw % (dist * vec3.right))
    end

    if KeyHeld (KEY.PageUp) or KeyHeld (KEY.Q) then
        C.cMov = C.cMov ^ mat4.Movement (dist * vec3.up)
    end

    if KeyHeld (KEY.PageDown) or KeyHeld (KEY.E) then
        C.cMov = C.cMov ^ mat4.Movement (dist * vec3.down)
    end
end

function SetCamera (mCam)
	local size = core.ScreenSize ()
    Sproj = core.util_projection (size.e.x, size.e.y, FOV);
    Sviewi = mCam
    Sviewproj = Sproj ^ mat4.Inverse (mCam)
end
