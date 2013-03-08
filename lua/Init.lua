local api_file = io.open ("API.h")
local api_text = api_file:read ("*all")
ffi = require ("ffi")
ffi.cdef (api_text)
core = ffi.C
core.XPull ("Loop")
core.XPull ("REPL")
core.XPull ("KeyDefs")
KeyDefs ()

function KeyDown (key)
    return (core.XKeyboard (key) > 1)
end
