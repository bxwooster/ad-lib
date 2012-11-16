uniform vec3 color;
uniform mat4 mv;
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
    vec3 normal_part2 = mv[2].xyz * w;
	vec3 normal = normal_part1 + normal_part2;
	// I hope the last 2 operations are a single MAD
    vec3 signflip = vec3 (1.0, 1.0, -1.0);

    result = textureCube (texture, normal * signflip).rgb;

    vec3 lightdir = vec3 (0.0, 1.0, 0.0);
    float ambient = 0.3;
    float light = ambient + clamp (dot (normal, lightdir), 0.0, 1.0);

    float brightness = 1.5;
    result *= brightness;
    result *= color;
    result *= effect;
    result *= light;

    gl_FragColor = vec4 (result, 0.0);
}

