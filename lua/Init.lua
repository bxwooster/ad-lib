function Init ()
    FFI = require ("ffi")
    BIT = require ("bit")
	GL = require ("lua/GL")
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI.cdef (api_text)
    core = FFI.C

	core.Require ("GLI")
    core.Require ("Lib")
    core.Require ("Util")
    core.Require ("Test")
    core.Require ("Loop")
    core.Require ("KeyDefs")
end
