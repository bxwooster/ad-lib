C.Xstone_frame_G1 (E);
C.Xstone_frame_G2 (E);
C.Xstone_frame_G3 (E);
C.Xstone_frame_C (E);

if (KeyDown (26)) then
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end

if (KeyDown (17)) then
    normalview = not normalview
    C.Xset_normalview (E, normalview)
end

if (KeyDown (41)) then
    C.Xhalt (E)
end

if (KeyDown (15)) then
    REPL ()
end
