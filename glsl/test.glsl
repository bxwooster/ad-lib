uniform vec2 resolution; // = vec2(stage_width, stage_height)
uniform vec2 object_pos; // center of object's bounding box
uniform vec2 object_halfsize; // = vec2(width, height) / 2
uniform vec2 offset;
uniform float blur_radius;
uniform float spread; // = spread_distance * (inset ? -1 : 1)
uniform bool inset;
uniform bool spread_method;

uniform sampler2D scene;
uniform sampler2D buffer; // result of last pass
uniform isampler1D linear; // special 1D buffer for case B

const float gaussian_C = 2.8;
const float erf_C = 0.53;
const float pi = 3.1415926;

float to_unorm(float r) {
	return 1.0 - r / 255.0;
}

float from_unorm(float p) {
	return 255.0 * (1.0 - p);
}

void inside_clip(float sx, float sy) {
	vec2 s = vec2(sx, sy);

	vec2 corrected_halfsize = object_halfsize - s;

	// signed distance to object's bounding-box
	vec2 i1 = gl_FragCoord.xy - (object_pos - corrected_halfsize);
	vec2 i2 = (object_pos + corrected_halfsize) - gl_FragCoord.xy;
	// are we inside/outside?
	if (inset != all(greaterThan(vec4(i1, i2), vec4(0)))) discard;
}

vec4 clip_dist(float qx, float qy) {
	vec2 q = vec2(qx, qy);

	// shadow's bounding-box
	vec2 real_pos = object_pos + offset;
	vec2 real_halfsize = object_halfsize + q;

	// signed distance to it
	vec2 r1 = gl_FragCoord.xy - (real_pos - real_halfsize);
	vec2 r2 = (real_pos + real_halfsize) - gl_FragCoord.xy;

	return vec4(r1, r2);
}

void clip(float qx, float qy) {
	vec4 r = clip_dist(qx, qy);
	if (any(lessThan(r, vec4(0)))) discard;
}

#if defined A1
out vec4 colour;

void main(void) {
	colour = texture (scene, gl_FragCoord.xy/resolution);
	if (inset != (colour.a > 0)) return;

	float q = blur_radius + spread;
	vec4 r = clip_dist(q, q);
	if (!inset && any(lessThan(r, vec4(0)))) discard;
	inside_clip(0, 0);

	// analytical Gaussian blur over 2D box
	vec4 dir = clamp(r / blur_radius, 0.0, 2.0);
	vec4 x = (dir - 1) * sqrt(2.0); // -sqrt(2) to sqrt(2)
	vec4 x2 = x*x;
	vec4 ax2 = x2*0.140012;
	// error function approximation
	vec4 erf = sign(x)*sqrt(1 - exp(-x2*(4/pi + ax2)/(1+ax2)));
	vec4 val = 0.5 - erf*erf_C;
	vec4 inv = 1.0 - val;

	float result = inv.x*inv.y*inv.z*inv.w;
	colour.rgb *= (inset ? result : 1.0 - result);
}

#elif defined C1 || defined B1
out float result;

void main(void) {
	clip(spread, 0);

	vec2 coord = gl_FragCoord.xy - offset;
	float R = abs(spread);
	float least = 256.0;
	for(float dx = -R; dx <= R; dx += 1) {
		float alpha = texture(scene, (coord+vec2(dx,0))/resolution).a;
		least = min(least, (alpha > 0) == (spread >= 0) ? abs(dx) : 256.0);
	}

	result = to_unorm(least);
}

#elif defined C2 || defined B2
out float result;

void main(void) {
	clip(spread, spread);

	float R = abs(spread);
	float least = 256.0;
	for(float dy = -R; dy <= R; dy+=1) {
		float u = texture(buffer, (gl_FragCoord.xy+vec2(0,dy))/resolution).r;
		float dx = from_unorm(u);
		least = min(least, spread_method ? length(vec2(dx, dy)) : dx);
	}

	result = (least < max(R, 1)) == (spread >= 0) ? 1.0 : 0.0;
}

#elif defined C3
out float result;

void main(void) {
	clip(spread + blur_radius, spread);
	
	float R = blur_radius;
	float sum = 0;
	float two_sigma2 = max(1e-5, R*R / 2);
	for (float dx = -R; dx <= R; dx += 1) {
		float a = texture(buffer, (gl_FragCoord.xy + vec2(dx,0)) / resolution).r;
		sum += (1.0 - a) * exp(-dx*dx / two_sigma2);
	}

	result = 1.0 - sum * inversesqrt(max(1, gaussian_C * two_sigma2));
}

#elif defined C4 || defined B5
out vec4 colour;

void main(void) {
	colour = texture(scene, gl_FragCoord.xy/resolution);
	if (inset != (colour.a > 0)) return;

	float q = spread + blur_radius;
	if (!inset) clip(q, q);

	float R = blur_radius;
	float sum = 0;
	float two_sigma2 = max(1e-5, R*R / 2);
	for (float dy = -R; dy <= R; dy += 1) {
		float a = texture(buffer, (gl_FragCoord.xy + vec2(0,dy)) / resolution).r;
		sum += a * exp(-dy*dy / two_sigma2);
	}

	float result = 1.0 - sum * inversesqrt(max(1, gaussian_C * two_sigma2));

	colour.rgb *= (inset ? 1.0 - result : result);
}

#elif defined B3
out ivec2 results;

void main(void) {
	float y = gl_FragCoord.x;
	vec2 start = object_pos + offset - object_halfsize - spread;
	vec2 end = object_pos + offset + object_halfsize + spread;
	if (y < start.y || y > end.y) discard;

	float at = start.x;
	for (; at <= end.x; at++) {
		float mask = texture(buffer, vec2(at, y)/resolution).r;
		if (mask == 1.0) {
			break;
		}
	}

	float at2 = end.x;
	for (; at2 > at; at2--) {
		float mask = texture(buffer, vec2(at2, y)/resolution).r;
		if (mask == 1.0) {
			break;
		}
	}

	results.r = int(at);
	results.g = int(at2) + 1;
}

#elif defined B4
out float result;

void main(void) {
	clip(spread + blur_radius, spread);

	float q = blur_radius + spread;
	vec2 v = texture(linear, gl_FragCoord.y/resolution.y).xy;
	vec2 r = vec2(v.y - gl_FragCoord.x, gl_FragCoord.x - v.x) + blur_radius;

	// analytical Gaussian blur over line segment
	vec2 dir = clamp(r / blur_radius, 0.0, 2.0);
	vec2 x = (dir - 1) * sqrt(2.0); // -v2 to v2
	vec2 x2 = x*x;
	vec2 ax2 = x2*0.140012;
	// error function approximation
	vec2 erf = sign(x)*sqrt(1 - exp(-x2*(4/pi + ax2)/(1+ax2)));
	vec2 val = 0.5 - erf*erf_C;
	vec2 inv = 1.0 - val;

	result = inv.x*inv.y;
}

#endif
