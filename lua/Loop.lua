core.Xstone_frame_G1 (E);
core.Xstone_frame_G2 (E);
core.Xstone_frame_G3 (E);
core.Xstone_frame_C (E);

if (KeyDown (KEY.W)) then
    wireframe = not wireframe
    core.XSetWireframe (wireframe)
end

if (KeyDown (KEY.N)) then
    normalview = not normalview
    core.XSetNormalview (normalview)
end

if (KeyDown (KEY.Escape)) then
    core.XHalt ()
end

if (KeyDown (KEY.L)) then
    REPL ()
end
