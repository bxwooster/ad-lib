GLI = {}
-- GL Improvements

local function NewThing (Gen, Del, N)
	N = N or 1
	local function gc (X) Del (N, X) end
	local X = FFI.new ("GLuint [?]", N)
	Gen (N, X)
	return FFI.gc (X, gc)
end

function GLI.NewTexture (N)
	return NewThing (GL.GenTextures, GL.DeleteTextures, N)
end

function GLI.NewBuffer (N)
	return NewThing (GL.GenBuffers, GL.DeleteBuffers, N)
end

function GLI.NewVertexArray (N)
	return NewThing (GL.GenVertexArrays, GL.DeleteVertexArrays, N)
end

function GLI.NewQuery (N)
	return NewThing (GL.GenQueries, GL.DeleteQueries, N)
end

