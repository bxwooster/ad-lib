local api_file = io.open ("API.h")
local api_text = api_file:read ("*all")
ffi = require ("ffi")
ffi.cdef (api_text)
C = ffi.C
C.Xpull (E, "Loop")
C.Xpull (E, "REPL")

function KeyDown (key)
    return (C.Xkeyboard (E, key) > 1)
end
