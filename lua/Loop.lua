--core.Xstone_frame_G1 (E);
--core.Xstone_frame_G2 (E);
--core.Xstone_frame_G3 (E);
--core.Xstone_frame_C (E);

if (KeyDown (KEY.L)) then
    REPL ()
end

if (KeyDown (KEY.Escape)) then
    core.XHalt ()
end
