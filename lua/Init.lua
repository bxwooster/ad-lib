function Init ()
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    ffi = require ("ffi")
    ffi.cdef (api_text)
    core = ffi.C

    core.Pull ("Lib")
    core.Pull ("Loop")
    core.Pull ("World")
    core.Pull ("Camera")
    core.Pull ("KeyDefs")
end
