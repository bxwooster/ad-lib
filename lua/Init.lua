function Init ()
    FFI = require ("ffi")
    BIT = require ("bit")
	GL = require ("lua/GL")
    core = FFI.C
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI.cdef (api_text)

	core.Require ("GLI")
    core.Require ("GUI")
    core.Require ("Lib")
    core.Require ("Util")
    core.Require ("Loop")
    core.Require ("Camera")
    core.Require ("Sector")
    core.Require ("Sphere")
    core.Require ("Circle")
    core.Require ("KeyDefs")

    --core.Require ("Cosmos")
    core.Require ("AStar")
    core.Require ("World")
    core.Require ("System")
    core.Require ("Gameplay")
    core.Require ("Selection")

    core.Require ("Dach")
    core.Require ("MarchingCubes")
    core.Require ("Prototype")

    World = NewWorld ()
end
