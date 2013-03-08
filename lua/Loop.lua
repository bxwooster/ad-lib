C.Xstone_frame_G1 (E);
C.Xstone_frame_G2 (E);
C.Xstone_frame_G3 (E);
C.Xstone_frame_C (E);

if (KeyDown (KEY.W)) then
    wireframe = not wireframe
    C.Xset_wireframe (E, wireframe)
end

if (KeyDown (KEY.N)) then
    normalview = not normalview
    C.Xset_normalview (E, normalview)
end

if (KeyDown (KEY.Escape)) then
    C.Xhalt (E)
end

if (KeyDown (KEY.L)) then
    REPL ()
end
