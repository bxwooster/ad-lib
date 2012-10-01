uniform vec3 color;
uniform mat4 mv;
varying vec2 ixy;
varying vec2 uv;

void main (void) {
	vec3 result = vec3 (1.0);

	float radius = length (ixy);
	if (radius > 1.0) discard;

	float light = sqrt (1.0 - radius);

	float w = -sqrt (1.0 - dot (uv, uv));
	vec3 normal = mat3(mv) * vec3 (uv, w);

	result = 0.5 * normal + 0.5;
	//result = step (0.0, normal);

	float brightness = 1.6;
	result *= color * light * brightness;

	gl_FragColor = vec4 (result, 0.0);
}

