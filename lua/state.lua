if (not init) then
    init = true
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    local ffi = require ("ffi")
    ffi.cdef (api_text)
    C = ffi.C
end

if (C.Xkeyboard (E, 26) == 2) then --W
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end

if (C.Xkeyboard (E, 17) == 2) then --E
    normalview = not normalview
    C.Xset_normalview (E, normalview)
end

if (C.Xkeyboard (E, 41) == 2) then --Esc
    C.Xhalt (E)
end
