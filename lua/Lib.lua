function KeyDown (key)
    return (core.Keyboard (key) > 1)
end

function apply (f, x)
    for _,xi in ipairs (x) do f (xi) end
end

function REPL ()
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
end
