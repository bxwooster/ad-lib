uniform vec3 color;
varying vec2 ixy;

void main (void) {
	float radius = length (ixy);
	if (radius > 1.0) discard;
	float light = sqrt (1.0 - radius);
	gl_FragColor = vec4 (color * light, 0.0);
}

