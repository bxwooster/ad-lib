local lib
if FFI.os == "Windows" then
	lib = FFI.load ("OpenGL32.dll", "GLEW32.dll")
elseif FFI.os == "OSX" then
	lib = FFI.load ("OpenGL.framework/OpenGL")
else
	lib = FFI.load ("GL")
end

local function index (t, k)
	local cached = rawget (t, k)
	if cached then return cached end

	local g = "gl" .. k
	local function trylib (g) return lib[g] end
	local ok, value = pcall (trylib, g)
	if ok then
		t[k] = value
		return value
	end

	if FFI.os == "Windows" then
		local function trygpa (g)
			local ptr = lib.wglGetProcAddress (g)
			local ctype = FFI.typeof ("PFN" .. g:upper () .. "PROC") -- wow
			return FFI.cast (ctype, ptr)
		end
		local ok, value = pcall (trygpa, g)
		if ok then
			t[k] = value
			return value
		end
	end

	--error ("Can't find OpenGL symbol " .. k)
end

FFI.cdef [[ void * wglGetProcAddress (char const *); ]]

local table = require "lua/GL43"
--local table = require "lua/GLES20"

return setmetatable (table, {__index = index})
