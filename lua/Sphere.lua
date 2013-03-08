local this = ...

print ("Drawing!", core.mat4_print (this.transform), this.radius)
-- draw it
--
core.XSphere (this.transform, this.radius)
