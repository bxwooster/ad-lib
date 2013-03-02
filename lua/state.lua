local ffi = require ("ffi")
ffi.cdef [[void test (void)]]
ffi.C.test ()

io.write("I just get called a lot. Can't help it! Wahey!\n")
