#define PI 3.14159265359

vec4 gear(vec2 pos, vec2 center, float dir, float phase) {
	vec2 p = pos - center;
	
	float r = length(p);
	float t = smoothstep(0.0, 1.0, fract(iTime));
	t *= 2.0 * PI / 6.0;
	float a = atan(p.y, p.x) + (phase + t) * dir;
	float e = 0.20 + clamp(sin(a * 6.0) * 0.13, 0.0, 0.1);
	
	if (r < e) {
		return vec4(0.8 + e - r, 0.0, 0.0, 1.0);
	}
	else {
		return vec4(0.0);
	}
}

vec4 gears(vec2 uv) {
	vec4 c1 = gear(uv, vec2(0.0, 0.0), 1.0, 0.0);
	vec4 c2;
	if (abs(uv.y) < -uv.x) {
		c2 = gear(uv, vec2(-0.5, 0.0), -1.0, 0.095);
	}
	else if (abs(uv.y) < uv.x) {
		c2 = gear(uv, vec2(0.5, 0.0), -1.0, 0.095);
	}
	else if (abs(uv.x) < -uv.y) {
		c2 = gear(uv, vec2(0.0, -0.5), -1.0, 0.095);
	}
	else if (abs(uv.x) < uv.y) {
		c2 = gear(uv, vec2(0.0, 0.5), -1.0, 0.095);
	}
	
	return c1 * c1.a + c2 * c2.a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	uv -= 0.5;
	uv.x /= iResolution.y / iResolution.x;
	
	vec2 c = vec2(0.5, 0.0);
	
	float time = iTime;
	
	float t = 1.0 + mod(time * 0.1, 0.481);
	//float t = iTime;
	
	vec2 uv2 = uv / pow(t, 10.0);
	
	uv2.x += 0.5;
	
	vec4 col = gears(fract(uv2 * 5.0) - 0.5);
	
	for (int i = 1; i <= 2; i++) {
		col = mix(col, col.a * gears(fract(uv2 * 5.0) - 0.5), 1.0 - 1.0 / (pow(t, 10.0)));
		uv2 *= 50.2;
	}
	
	fragColor = col.a * col + vec4(vec3((uv.y + 1.0) * 0.2), 1.0) * (1.0 - col.a);
}