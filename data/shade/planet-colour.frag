uniform struct {
	mat4 mvp;
	mat4 mv;
	vec3 colour;
	float depth;
	float uvscale;
	samplerCube texture;
} I;

void main (void) {
    gl_FragColor = vec4 (I.colour, 0.0);
}

