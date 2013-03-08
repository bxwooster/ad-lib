core.stone_frame_G ();
core.stone_frame_C ();

apply (Transform, transforms)
core.PreSphere ()
apply (Sphere, spheres)

if (KeyDown (KEY.L)) then REPL () end
if (KeyDown (KEY.Escape)) then core.Halt () end
