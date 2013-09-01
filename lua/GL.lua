local lib
if FFI.os == "Windows" then
	lib = FFI.load ("OpenGL32.dll", "GLEW32.dll")
elseif FFI.os == "OSX" then
	lib = FFI.load ("OpenGL.framework/OpenGL")
else
	lib = FFI.load ("GL")
end

local WRAPPER = 1

local function wrapper (glfunc)
	return glfunc
end

if (WRAPPER == 1) then
	wrapper = function (glfunc)
		local E = core.GLError ()
		return function (...)
			local ok, result = pcall (glfunc, ...)
			if not ok then
				print (debug.traceback ())
				error (result)
			end
			if E.valid == 1 then
				E.valid = 0
				local msg = FFI.string (E.message, E.length)
				error (msg)
			end
			return result
		end
	end
end

local function index (t, k)
	local cached = rawget (t, k)
	if cached then return cached end

	local g = "gl" .. k
	local function trylib (g) return lib[g] end
	local ok, value = pcall (trylib, g)
	if ok then
		wrapped = wrapper (value)
		t[k] = wrapped
		return wrapped
	end

	if FFI.os == "Windows" then
		local function trygpa (g)
			local ptr = lib.wglGetProcAddress (g)
			local ctype = FFI.typeof ("PFN" .. g:upper () .. "PROC") -- wow
			return FFI.cast (ctype, ptr)
		end
		local ok, value = pcall (trygpa, g)
		if ok then
			wrapped = wrapper (value)
			t[k] = wrapped
			return wrapped
		end
	end

	--error ("Can't find OpenGL symbol " .. k)
end

FFI.cdef [[ void * wglGetProcAddress (char const *); ]]

local table = require "lua/GL43"
--local table = require "lua/GLES20"

return setmetatable (table, {__index = index})
