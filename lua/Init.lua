function Init ()
    FFI = require ("ffi")
    BIT = require ("bit")
	GL = require ("lua/GL")
    local api_file = io.open ("API.h")
    local api_text = api_file:read ("*all")
    FFI.cdef (api_text)
    core = FFI.C

	if GL.DebugMessageCallbackARB then
		GL.DebugMessageCallbackARB (core.DebugCallbackARB, nil)
		GL.Enable (GL.DEBUG_OUTPUT_SYNCHRONOUS_ARB)
	end

	core.Require ("GLI")
    core.Require ("GUI")
    core.Require ("Lib")
    core.Require ("Util")
    core.Require ("Loop")
    core.Require ("World")
    core.Require ("AStar")
    core.Require ("Camera")
    core.Require ("System")
    core.Require ("Sector")
    core.Require ("Sphere")
    core.Require ("Circle")
    core.Require ("KeyDefs")
    core.Require ("Gameplay")
    core.Require ("Selection")
    core.Require ("Prototype")

    World = NewWorld ()
end
