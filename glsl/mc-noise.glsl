#define M_PI 3.1415926535897932384626433832795

uniform sampler3D noise;
uniform float time;

#ifdef GS
float fun (vec3 pos) {
	vec3 c = abs(pos);
	float d = 0.25 - max (c.x, max (c.y, c.z));
	float s = -time*0.1+0.25 - dot (c,c);
	float w = 1; vec3 k = vec3 (1, 2, 0);
	float v = 0.2 * sin(time * w + dot (k, pos)) + pos.z - 0.5;
	//return pos.z;
	//return pos.z - 0.1 + 0.2 * texture (noise, pos/2.04 + time * 0.001).x;
	return sin(2 * M_PI * s + time* 5);
}
#endif
