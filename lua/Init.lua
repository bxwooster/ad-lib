function Init ()
    FFI = require ("ffi")
	require ("lua/GL")
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI.cdef (api_text)
    core = FFI.C

    core.Pull ("Lib")
    core.Pull ("Util")
    core.Pull ("Loop")
    core.Pull ("World")
    core.Pull ("AStar")
    core.Pull ("Camera")
    core.Pull ("System")
    core.Pull ("KeyDefs")

    World = NewWorld ()
end
