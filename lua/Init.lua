local api_file = io.open ("API.h")
local api_text = api_file:read ("*all")
ffi = require ("ffi")
ffi.cdef (api_text)
core = ffi.C

core.XPull ("Loop")
core.XPull ("REPL")
core.XPull ("KeyDefs")
core.XPull ("Sphere")

KeyDefs ()

function KeyDown (key)
    return (core.XKeyboard (key) > 1)
end

function apply (f, x)
    for _,xi in ipairs (x) do
        f (xi)
    end
end

local p1 = {transform = core.mat4_identity (), radius = 0.2}

spheres = {}
table.insert (spheres, p1)
