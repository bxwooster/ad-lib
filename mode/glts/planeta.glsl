vec4 vertex ();
vec3 fragment ();

#ifdef VS
	attribute vec2 Apos2d;
#endif

uniform mat4 Umvp;
uniform mat4 Umv;
uniform vec3 Ucolour;
uniform float Udepth;
uniform float Uuvscale;

uniform samplerCube Utexture;

#ifdef VS
	void main(void) {
		gl_Position = vertex ();
	}
#else
	void main(void) {
		gl_FragColor = vec4 (fragment (), 0.0);
	}
#endif
