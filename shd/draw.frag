varying vec2 ixy;

void main (void) {
	float radius = length (ixy);
	float light = 1.0 - radius * 1;
	vec3 color = vec3(1.0, 1.0, 1.0);
	gl_FragColor = vec4 (color * light, 0.0);
}
