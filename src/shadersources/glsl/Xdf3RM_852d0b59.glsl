#define PI 3.14159265359
#define GEAR_PHASE 0.0958

vec2 cmul(vec2 v1, vec2 v2) {
	return vec2(v1.x * v2.x - v1.y * v2.y, v1.y * v2.x + v1.x * v2.y);
}

vec2 cdiv(vec2 v1, vec2 v2) {
	return vec2(v1.x * v2.x + v1.y * v2.y, v1.y * v2.x - v1.x * v2.y) / dot(v2, v2);
}

vec4 gear(vec2 uv, float dir, float phase) {
	vec2 p = uv - 0.5;
	
	float r = length(p);
	float t = smoothstep(0.0, 1.0, fract(iTime));
	t *= 2.0 * PI / 6.0;
	float a = atan(p.y, p.x) + (phase + t) * dir;
	float e = 0.20 + clamp(sin(a * 6.0) * 0.13, 0.0, 0.1);
	
	if (r < e) {
		return vec4(0.7 + e - r, 0.0, 0.0, 1.0);
	}
	else {
		return vec4(0.0);
	}
}

vec4 gears(vec2 uv) {
	vec4 c1 = gear(uv, 1.0, 0.0);
	vec4 c2 = gear(vec2(fract(uv.x + 0.5), uv.y), -1.0, GEAR_PHASE);
	vec4 c3 = gear(vec2(uv.x, fract(uv.y + 0.5)), -1.0, GEAR_PHASE);
	
	return c1 * c1.a + c2 * c2.a + c3 * c3.a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	uv -= 0.5;
	uv.x /= iResolution.y / iResolution.x;
	
	float t = sin(iTime * 0.1) * 6.0;
	vec2 a = vec2(3.0, 0.0);
	vec2 b = vec2(0.0, 0.0);
	vec2 c = vec2(0.0, t);
	vec2 d = vec2(0.0, 1.0);
	vec2 uv2 = cdiv(cmul(uv, a) + b, cmul(uv, c) + d);
	
	vec4 col = gears(fract(uv2));
	
	fragColor = col.a * col + vec4(abs(dot(uv, normalize(uv2))) * 0.25) * (1.0 - col.a);
}