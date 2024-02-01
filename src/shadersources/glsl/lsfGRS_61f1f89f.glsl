float square( vec2 p, float b )
{
	vec2 d = abs(p) - b;
	return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

float circle(vec2 p, float b)
{
	return length(p) - b;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 p = fragCoord.xy / iResolution.xy * 2.0;
	p.x *= iResolution.x / iResolution.y;
	p.x -= 0.75;
	float d = 1.0;
	float s = 1.0;
	for (int i = 0; i < 7; i++) {
		p = abs(p - s);
		s *= 0.5;
		d = min(d, circle(p, s));
	}

	fragColor = vec4(1.0 - step(d, 0.0) - d);
}