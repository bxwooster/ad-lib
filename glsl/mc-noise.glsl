uniform sampler3D noise;
uniform float time;

#ifdef GS
float fun (vec3 pos) {
	return pos.z - 0.1 + 0.2 * texture (noise, pos/2.04 + time * 0.001).x;
}
#endif
