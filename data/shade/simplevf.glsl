vec4 vertex ();
vec3 fragment ();

#ifdef VS
	void main(void) {
		gl_Position = vertex ();
	}
#else
	void main(void) {
		gl_FragColor = vec4 (fragment (), 0.0);
	}
#endif
