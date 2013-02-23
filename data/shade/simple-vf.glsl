vec4 vertex ();
vec3 fragment ();

#if defined VS
	void main(void) {
		gl_Position = vertex ();
	}
#elif defined FS
	void main(void) {
		gl_FragColor = vec4 (fragment (), 0.5);
	}
#endif
