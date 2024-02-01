float dist(vec2 p1, vec2 p2) {
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	return sqrt(dx * dx + dy * dy);	
}

float getSin(float seed, float a, float f, float t) {
	return a*sin(seed * f + t);
}

float getCos(float seed, float a, float f, float t) {
	return a*cos(seed * f + t);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float t = iTime;
	vec2 mid = vec2(0.5,0.5);
	vec2 focus = iMouse.xy / iResolution.xy;
	float d = dist(focus, uv);
	float mod1 = sin(t * 15.0) * 0.2;
	float c = d * 17.5 + mod1;
	fragColor = vec4(1.0 - c, 0.0, 0.0, 1.0);
}