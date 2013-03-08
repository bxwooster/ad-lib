C.Xstone_frame_G1 (E);
C.Xstone_frame_G2 (E);
C.Xstone_frame_G3 (E);
C.Xstone_frame_C (E);

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
    REPL ()
end
