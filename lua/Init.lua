local api_file = io.open ("API.h")
local api_text = api_file:read ("*all")
ffi = require ("ffi")
ffi.cdef (api_text)
C = ffi.C
C.XPull ("Loop")
C.XPull ("REPL")
C.XPull ("KeyDefs")
KeyDefs ()

function KeyDown (key)
    return (C.XKeyboard (key) > 1)
end
