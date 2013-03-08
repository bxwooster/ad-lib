core.Xstone_frame_G ();
core.Xstone_frame_C ();

apply (Transform, transforms)
core.XPreSphere ()
apply (Sphere, spheres)

if (KeyDown (KEY.L)) then REPL () end
if (KeyDown (KEY.Escape)) then core.XHalt () end
