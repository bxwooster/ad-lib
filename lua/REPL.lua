local line
while (true) do
    io.write (">>> ")
    line = io.read ()
    if (line == "exit") then
        break
    end
    local chunk, err = loadstring ("print(" .. line .. ")", ">>>")
    if (chunk) then
        local ok, result = pcall (chunk)
        if (not ok) then
            print (result)
        end
    elseif (result) then
        print (result)
    end
end
