uniform mat4 mvp;
uniform float depth;
varying vec2 ixy;
attribute vec2 pos;

void main (void) {
	gl_Position = mvp * vec4 (pos, 0.0, 1.0);
	gl_Position.z = depth * gl_Position.w;
	ixy = pos;
}

