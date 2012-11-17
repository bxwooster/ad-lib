uniform struct {
	mat4 mvp;
	mat4 mv;
	vec3 colour;
	float depth;
	float uvscale;
} I;
uniform samplerCube texture;

varying vec2 ixy;
varying vec2 uv;
varying vec3 normal_part1;

void main (void) {
    vec3 result = vec3 (1.0);

    float radius = length (ixy);
    if (radius > 1.0) discard;

    float effect = sqrt (1.0 - radius);

    float w = -sqrt (1.0 - dot (uv, uv));
    vec3 normal_part2 = I.mv[2].xyz * w;
	vec3 normal = normal_part1 + normal_part2;

    gl_FragColor = vec4 (normal, 0.0);
}

