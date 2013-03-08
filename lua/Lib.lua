function KeyDown (key)
    return (core.Keyboard (key) > 1)
end

function apply (f, x)
    for _,xi in ipairs (x) do
        f (xi)
    end
end
