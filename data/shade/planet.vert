uniform mat4 mvp;
uniform mat4 mv;
uniform float depth;
uniform float uvscale;
varying vec2 ixy;
varying vec2 uv;
varying vec3 normal_part1;
attribute vec2 pos;

void main (void) {
    gl_Position = mvp * vec4 (pos, 0.0, 1.0);
    gl_Position.z = depth * gl_Position.w;
    ixy = pos;
    uv = pos * uvscale;
	normal_part1 = mat3 (mv) * vec3 (uv, 0.0);
}

