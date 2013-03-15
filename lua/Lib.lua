-- vecmat: "newindex"? prevent mutation

function apply (f, x)
    for _,xi in ipairs (x) do f (xi) end
end

do
    local function iter (a, i)
        i = i + 1
        local v = a[i]
        if v then
            return i, v
        end
    end

    function zpairs (a)
        return iter, a, -1
    end
end

function KeyDown (key)
    return (Core.Key (key) > 1)
end

function KeyHeld (key)
    return (Core.Key (key) > 0)
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
    while true do
        io.write ">>> "
        line = io.read ()
        if line == "exit" then
            break
        end
        local chunk, err = loadstring ("print(" .. line .. ")", ">>>")
        if chunk then
            local ok, result = pcall (chunk)
            if not ok then
                print (result)
            end
        elseif result then
            print (result)
        end
    end
end

do
    Vec2 = {
        New = Core.vec2_new,
        Random = Core.vec2_random,
        Print = Core.vec2_print,
        Scaled = Core.vec2_scaled,
        Normalized = Core.vec2_normalized,
        Dot = Core.vec2_dot,
    }

    Vec2.left = Vec2.New (-1, 0)
    Vec2.right = Vec2.New (1, 0)
    Vec2.forward = Vec2.New (0, 1)
    Vec2.back = Vec2.New (0, -1)
    Vec2.zero = Vec2.New (0, 0)

    Vec2.x = Vec2.right
    Vec2.y = Vec2.forward

    local v2s = Vec2.Scaled
    local v2mt = {}
    v2mt.__add = Core.vec2_sum
    v2mt.__sub = Core.vec2_diff
    v2mt.__concat = Core.vec2_dot
    v2mt.__mul = function (a, b)
        return type (a) == 'number' and v2s (b, a) or v2s (a, b)
    end
    v2mt.__div = Core.vec2_divided
    v2mt.__unm = function (v) return v2s (v, -1) end

    FFI.metatype ("vec2", v2mt)
end

do
    Vec3 = {
        New = Core.vec3_new,
        Random = Core.vec3_random,
        Print = Core.vec3_print,
        Scaled = Core.vec3_scaled,
        Normalized = Core.vec3_normalized,
        Length = Core.vec3_length,
        Dot = Core.vec3_dot,
    }

    Vec3.left = Vec3.New (-1, 0, 0)
    Vec3.right = Vec3.New (1, 0, 0)
    Vec3.forward = Vec3.New (0, 1, 0)
    Vec3.back = Vec3.New (0, -1, 0)
    Vec3.up = Vec3.New (0, 0, 1)
    Vec3.down = Vec3.New (0, 0, -1)
    Vec3.zero = Vec3.New (0, 0, 0)

    Vec3.x = Vec3.right
    Vec3.y = Vec3.forward
    Vec3.z = Vec3.up

    local v3s = Vec3.Scaled
    local v3mt = {}
    v3mt.__add = Core.vec3_sum
    v3mt.__sub = Core.vec3_diff
    v3mt.__concat = Core.vec3_dot
    v3mt.__mul = function (a, b)
        return type (a) == 'number' and v3s (b, a) or v3s (a, b)
    end
    v3mt.__div = Core.vec3_divided
    v3mt.__mod = Core.vec3_multiply
    v3mt.__unm = function (v) return v3s (v, -1) end

    FFI.metatype ("vec3", v3mt)
end

do
    Mat4 = {
        Movement = Core.mat4_movement,
        Moved = Core.mat4_moved,
        Rotation = Core.mat4_rotation_aa,
        Rotated = Core.mat4_rotated_aa,
        Inverse = Core.mat4_inverted_rtonly,
        Print = Core.mat4_print,

        id = Core.mat4_identity ()
    }

    local m4mt = {}
    m4mt.__pow = Core.mat4_multiply

    FFI.metatype ("mat4", m4mt);
end

do
    Colour = {
        white = Vec3.New (1, 1, 1),
        red = Vec3.New (1, 0, 0),
        green = Vec3.New (0, 1, 0),
        blue = Vec3.New (0, 0, 1),
        yellow = Vec3.New (1, 1, 0),
        magenta = Vec3.New (1, 0, 1),
        cyan = Vec3.New (0, 1, 1),
        black = Vec3.New (0, 0, 0),
    }
end
