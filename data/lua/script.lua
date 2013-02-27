local ffi = require ("ffi")
ffi.cdef [[void test (void)]]
ffi.C.test ()
-- Sample code below
io.write("The table the script received has:\n");
x = 0
for i = 1, #foo do
    print(i, foo[i])
    x = x + foo[i]
end
io.write("Returning data back to C\n");
return x
