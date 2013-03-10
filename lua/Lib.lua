function KeyDown (key)
    return (core.Key (key) > 1)
end

function KeyHeld (key)
    return (core.Key (key) > 0)
end

function apply (f, x)
    for _,xi in ipairs (x) do f (xi) end
end

function table.print (t)
    for k, v in pairs (t) do print (k, v) end
end

function table.copy (t)
    local c = {}
    for k, v in pairs (t) do
        c[k] = v
    end
    return c
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

do
    local v2t = {
        New = core.vec2_new,
        Random = core.vec2_random,
        Print = core.vec2_print,
        Scaled = core.vec2_scaled,
        Scale = core.vec2_scale,
        Normalized = core.vec2_normalized,
        Normalize = core.vec2_normalize,
        Length = core.vec2_length,
    }

    vec2 = table.copy (v2t)

    vec2.left = vec2.New (-1, 0)
    vec2.right = vec2.New (1, 0)
    vec2.forward = vec2.New (0, 1)
    vec2.back = vec2.New (0, -1)
    vec2.zero = vec2.New (0, 0)

    vec2.x = vec2.right
    vec2.y = vec2.forward

    local v2s = vec2.Scaled
    local v2mt = {}
    v2mt.__add = core.vec2_sum
    v2mt.__sub = core.vec2_diff
    v2mt.__concat = core.vec2_dot
    v2mt.__mul = function (a, b)
        return type (a) == 'number' and v2s (b, a) or v2s (a, b)
    end
    v2mt.__unm = function (v) return v2s (v, -1) end
    v2mt.__index = function (v, key)
        if v2t[key] ~= nil then
            return v2t[key]
        else
            return rawget (v, key)
        end
    end

    ffi.metatype ("vec2", v2mt)
end

do
    local v3t = {
        New = core.vec3_new,
        Random = core.vec3_random,
        Print = core.vec3_print,
        Scaled = core.vec3_scaled,
        Scale = core.vec3_scale,
        Normalized = core.vec3_normalized,
        Normalize = core.vec3_normalize,
        Length = core.vec3_length,
        Dot = core.vec3_dot,
    }

    vec3 = table.copy (v3t)

    vec3.left = vec3.New (-1, 0, 0)
    vec3.right = vec3.New (1, 0, 0)
    vec3.forward = vec3.New (0, 1, 0)
    vec3.back = vec3.New (0, -1, 0)
    vec3.up = vec3.New (0, 0, 1)
    vec3.down = vec3.New (0, 0, -1)
    vec3.zero = vec3.New (0, 0, 0)

    vec3.x = vec3.right
    vec3.y = vec3.forward
    vec3.z = vec3.up

    local v3s = v3t.Scaled
    local v3mt = {}
    v3mt.__add = core.vec3_sum
    v3mt.__sub = core.vec3_diff
    v3mt.__concat = core.vec3_dot
    v3mt.__mul = function (a, b)
        return type (a) == 'number' and v3s (b, a) or v3s (a, b)
    end
    v3mt.__unm = function (v) return v3s (v, -1) end
    v3mt.__index = function (v, key)
        if v3t[key] ~= nil then
            return v3t[key]
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
        Print = core.mat4_print,

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

-- left:
--  vec4_multiply
--  vec3_product
--  vec3_dot
--  vec2_dot
--  from
