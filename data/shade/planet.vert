uniform struct {
	mat4 mvp;
	mat4 mv;
	vec3 colour;
	float depth;
	float uvscale;
} I;
uniform samplerCube texture;

attribute vec2 pos;

varying vec2 ixy;
varying vec2 uv;
varying vec3 normal_part1;

void main (void) {
    gl_Position = I.mvp * vec4 (pos, 0.0, 1.0);
    gl_Position.z = I.depth * gl_Position.w;
    ixy = pos;
    uv = pos * I.uvscale;
	normal_part1 = mat3 (I.mv) * vec3 (uv, 0.0);
}

