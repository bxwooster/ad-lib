if (not init) then
    init = true
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    C = ffi.C
end

if (C.Xkeyboard (E, 26) == 2) then --W
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end

if (C.Xkeyboard (E, 17) == 2) then --N
    normalview = not normalview
    C.Xset_normalview (E, normalview)
end

if (C.Xkeyboard (E, 41) == 2) then --Esc
    C.Xhalt (E)
end

if (C.Xkeyboard (E, 15) == 2) then --L
    local line
    while (true) do
        io.write (">>> ")
        line = io.read ()
        if (line == "exit") then
            break
        end
        local chunk, err = loadstring (line, ">>>")
        if (chunk) then
            local ok, err = pcall (chunk)
            if (not ok) then
                print (err)
            end
        else
            print (err)
        end
    end
end
