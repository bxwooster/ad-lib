varying vec2 Vixy;
varying vec2 Vuv;
varying vec3 Vnormal_part1;

#ifdef VS
vec4 vertex () {
    vec4 position = U.mvp * vec4 (Apos2d, 0.0, 1.0);
    position.z = U.depth * position.w;
    Vixy = Apos2d;
    Vuv = Apos2d * U.uvscale;
	Vnormal_part1 = mat3 (U.mv) * vec3 (Vuv, 0.0);

	return position;
}
#else
float discard_test () {
    float radius = length (Vixy);
    if (radius > 1.0) discard;
	return radius;
}
#endif

vec3 the_normal () {
    float w = -sqrt (1.0 - dot (Vuv, Vuv));
    vec3 normal_part2 = U.mv[2].xyz * w;
	vec3 normal = Vnormal_part1 + normal_part2;
	// I hope the last 2 operations are a single MAD
	// -- How insignificant that is, really...
    vec3 signflip = vec3 (1.0, 1.0, -1.0);

	return normal * signflip;
}

