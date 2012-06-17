void main (void) {
	vec2 screen = gl_FragCoord.xy / 320 - 1.0;
	float radius = length (screen);
	float light = 1.0 - radius * 2;
	vec3 color = vec3(1.0, 1.0, 1.0);
	gl_FragColor = vec4 (color * light, 0.0);
}

