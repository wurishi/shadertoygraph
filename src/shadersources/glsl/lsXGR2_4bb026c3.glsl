
float map(vec3 p) {
	float musica = texture(iChannel1, vec2(0.1, 0.0)).x;
	return musica + dot(p, vec3(0, 1, 0)) - (sin(p.x) + sin(p.z)) * musica;
}

vec2 rot(vec2 ax, float r) {
	return vec2(
		cos(r) * ax.x - sin(r) * ax.y,
		sin(r) * ax.x + cos(r) * ax.y);
		
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
	vec3 pos = vec3(iTime + texture(iChannel1, vec2(0.1, 0.1)).x, 5, iTime * 3.0);
	vec3 dir = normalize(vec3(uv, 1.0));
	dir.xz = rot(dir.xz , iTime * 0.1);
	dir.xy = rot(dir.xy , iTime * 0.1 + sin(iTime * 0.2));
	float t = 0.0;
	for(int i = 0; i < 50; i++) {
		t += map(pos + dir * t);
	}
	vec3 ip = pos + dir * t;
	
	//Thanks!
	//vec3 col = texture(iChannel0, mod(ip.xz * 0.1, 1.0)).xyz;
	vec3 col = texture(iChannel0, ip.xz * 0.1, 1.0).xyz;
	
	col *= max(0.0, map(ip + normalize(vec3(2, 3, 4)) * 2.1));
	fragColor = vec4(vec3(col + vec3(t * 0.01)), 0.0);
}