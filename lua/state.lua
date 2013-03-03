if (not init) then
    init = true
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    local ffi = require ("ffi")
    ffi.cdef (api_text)
    C = ffi.C

    wireframe = 1
end

if (C.Xkeyboard (E, 26) == 2) then --W
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end
