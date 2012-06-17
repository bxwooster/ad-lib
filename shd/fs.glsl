void main (void) {
	vec2 xy = gl_FragCoord.xy / 160 - 2.0;
	float radius = length (xy);
	gl_FragColor = vec4 (1.0 - radius);
}

