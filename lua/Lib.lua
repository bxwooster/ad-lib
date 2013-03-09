function KeyDown (key)
    return (core.Keyboard (key) > 1)
end

function KeyHeld (key)
    return (core.Keyboard (key) > 0)
end

function apply (f, x)
    for _,xi in ipairs (x) do f (xi) end
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

    left = core.vec3_new (-1, 0, 0),
    right = core.vec3_new (1, 0, 0),
    forward = core.vec3_new (0, 1, 0),
    back = core.vec3_new (0, -1, 0),
    up = core.vec3_new (0, 0, 1),
    down = core.vec3_new (0, 0, -1),
}

mat4 = {
    Movement = core.mat4_movement,

    id = core.mat4_identity ()
}
