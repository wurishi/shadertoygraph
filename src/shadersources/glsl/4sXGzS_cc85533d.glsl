float bf(vec2 p, float r)  { return length(abs(mod(p, 10.0)) - 5.0) - r; }
vec2  rot(vec2 p, float a) { return vec2(p.x * cos(a) - p.y * sin(a), p.x * sin(a) + p.y * cos(a)); }

float map(vec3 p) {
	float k = 5.0 - dot(abs(p), vec3(0, 1, 0)) + (cos(p.z) + cos(p.x)) * 0.4;
	return max(max(k, -bf(p.xz, 4.0)), -bf(p.zy, 3.5));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec3 dir = normalize(vec3( vec2(iResolution.x / iResolution.y, 1.0) * (-1.0 + 2.0 * (fragCoord.xy / iResolution.xy )), 1.0));
	float a = -iTime * 0.1;
	dir.xz = rot(dir.xz, sin(a * 4.0));
	dir.xy = rot(dir.xy, -a);
	vec3 pos = vec3(iTime * 4.0, 0, iTime * 7.0);
	vec3 npos = pos;
	float t  = 0.0;
	for(int i = 0 ; i < 75; i++) {
		npos = pos + dir * t;
		t += map(npos);
	}
	vec3 c1 = vec3(1, 2, 3);
	vec3 col = 0.1 * mix(c1, c1.yzx, t * 0.7) * map(npos * abs(vec3(8, 11, 9))) * 2.0;
	fragColor = vec4(1.5-abs(sqrt(3.0 - col) + t * 0.01), 1.0 );
}
