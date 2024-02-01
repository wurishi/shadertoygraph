vec3 hsv(in float h, in float s, in float v) {
	return mix(vec3(1.0), clamp((abs(fract(h + vec3(3, 2, 1) / 3.0) * 6.0 - 3.0) - 1.0), 0.0 , 1.0), s) * v;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
	p.x *= iResolution.x / iResolution.y;
	vec2 c = vec2(-iTime*0.154, iTime*0.2485);
	float d = 1.0;
	vec3 col = vec3(0);
	float t = iTime;
	for (int i = 0; i < 20; i++) {
		float r = length(p);
		p /= r;
		p = asin(sin(p/r + c));
		col += hsv(r, max(1.0-dot(p,p), 0.0), 1.0);
	}
	fragColor = vec4(sin(col)*0.5+0.5,
			    		1.0);
}