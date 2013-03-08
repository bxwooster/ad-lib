C.Xstone_frame_G1 (E);
C.Xstone_frame_G2 (E);
C.Xstone_frame_G3 (E);
C.Xstone_frame_C (E);

if (KeyDown (KEY.W)) then
    wireframe = not wireframe
    C.XSetWireframe (wireframe)
end

if (KeyDown (KEY.N)) then
    normalview = not normalview
    C.XSetNormalview (normalview)
end

if (KeyDown (KEY.Escape)) then
    C.XHalt ()
end

if (KeyDown (KEY.L)) then
    REPL ()
end
