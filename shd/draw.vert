uniform mat4 mvp;
varying vec2 ixy;
attribute vec2 pos;

void main (void) {
	gl_Position = mvp * vec4 (pos, 0.0, 1.0);
	ixy = pos;
}
