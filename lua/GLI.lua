GLI = {}
-- GL Improvements

local function NewThing (Gen, Del)
	local function gc (X) Del (1, X) end
	local X = FFI.new ("GLuint [1]")
	Gen (1, X)
	return FFI.gc (X, gc)
end

function GLI.NewTexture ()
	return NewThing (GL.GenTextures, GL.DeleteTextures)
end

function GLI.NewBuffer ()
	return NewThing (GL.GenBuffers, GL.DeleteBuffers)
end

function GLI.NewVertexArray ()
	return NewThing (GL.GenVertexArrays, GL.DeleteVertexArrays)
end

function GLI.NewQuery ()
	return NewThing (GL.GenQueries, GL.DeleteQueries)
end

