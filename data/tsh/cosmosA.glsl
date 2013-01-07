vec4 vertex ();
vec3 fragment ();

#ifdef VS
	attribute vec2 Apos2d;
#endif

struct {
	mat4 mvp;
	mat4 mv;
	vec3 colour;
	float depth;
	float uvscale;
} U;

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
