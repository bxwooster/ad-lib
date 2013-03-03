local ffi = require ("ffi")
ffi.cdef [[
char api_key_pressed (unsigned key);
]]

if (ffi.C.api_key_pressed (74) ~= 0) then --home
    print ("Yep. Home.")
end
