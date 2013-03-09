function KeyDown (key)
    return (core.Keyboard (key) > 1)
end

function KeyHeld (key)
    return (core.Keyboard (key) > 0)
end

function apply (f, x)
    for _,xi in ipairs (x) do f (xi) end
end

function tprint (t)
    for k, v in pairs (t) do print (k, v) end
end

function REPL ()
    local line
    while (true) do
        io.write (">>> ")
        line = io.read ()
        if (line == "exit") then
            break
        end
        local chunk, err = loadstring ("print(" .. line .. ")", ">>>")
        if (chunk) then
            local ok, result = pcall (chunk)
            if (not ok) then
                print (result)
            end
        elseif (result) then
            print (result)
        end
    end
end

vec3 = {
    New = core.vec3_new,
    Random = core.vec3_random,

    left = core.vec3_new (-1, 0, 0),
    right = core.vec3_new (1, 0, 0),
    forward = core.vec3_new (0, 1, 0),
    back = core.vec3_new (0, -1, 0),
    up = core.vec3_new (0, 0, 1),
    down = core.vec3_new (0, 0, -1),
    zero = core.vec3_new (0, 0, 0),
}

do
    vec3.x = vec3.right
    vec3.y = vec3.forward
    vec3.z = vec3.up

    local v3s = core.vec3_scaled
    local v3mt = {}
    v3mt.__add = core.vec3_sum
    v3mt.__sub = core.vec3_diff
    v3mt.__mul = function (a, b)
    return type (a) == 'number' and v3s (b, a) or v3s (a, b)
    end
    v3mt.__unm = function (v) return v3s (v, -1) end
    v3mt.__index = function (v, key)
    if vec3[key] ~= nil then
    return vec3[key]
    else
    return rawget (v, key)
    end
    end

    ffi.metatype ("vec3", v3mt)
end

do
    mat4 = {
        Movement = core.mat4_movement,
        Moved = core.mat4_moved,
        Move = core.mat4_move,
        RotatedAA = core.mat4_rotated_aa,
        RotateAA = core.mat4_rotate_aa,
        InvertRT = core.mat4_invert_rtonly,
        InvertedRT = core.mat4_inverted_rtonly,

        id = core.mat4_identity ()
    }

    local m4mt = {}
    m4mt.__pow = core.mat4_multiply
    m4mt.__index = function (m, key)
        if mat4[key] ~= nil then
            return mat4[key]
        else
            return rawget (v, key)
        end
    end

    ffi.metatype ("mat4", m4mt);
end
