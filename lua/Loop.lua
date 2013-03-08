if (C.Xkeyboard (E, 26) == 2) then --W
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end

if (C.Xkeyboard (E, 17) == 2) then --N
    normalview = not normalview
    C.Xset_normalview (E, normalview)
end

if (C.Xkeyboard (E, 41) == 2) then --Esc
    C.Xhalt (E)
end

if (C.Xkeyboard (E, 15) == 2) then --L
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
