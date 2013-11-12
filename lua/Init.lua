function Init ()
    FFI = require ("ffi")
    BIT = require ("bit")
	GL = require ("lua/GL")
    core = FFI.C
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI.cdef (api_text)

	core.Require ("GLI")
    core.Require ("Lib")
    core.Require ("Util")
    core.Require ("KeyDefs")

    core.Require ("Loop")

    core.Require ("Five")
end
