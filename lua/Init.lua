function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI = require ("ffi")
    FFI.cdef (api_text)
    Core = FFI.C

    Core.Pull ("Lib")
    Core.Pull ("Loop")
    Core.Pull ("World")
    Core.Pull ("Camera")
    Core.Pull ("System")
    Core.Pull ("KeyDefs")
end
