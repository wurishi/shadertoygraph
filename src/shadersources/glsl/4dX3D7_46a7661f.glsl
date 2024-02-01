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
	
	float tm = t * 2.5;
	
	float f1 = getSin(uv.y, 3.5, t * 2.0, tm) + cos(t * 5.0);
	float f2 = getCos(dist(uv, mid),5.0,2.0,t) + sin(tm);
	float c = getSin(uv.x, 1.0, f1, tm) + getCos(uv.y,2.0, f2, -tm);
	
	fragColor = vec4(c * 0.5, 0.5 + uv.y * 0.5, 0.0, 1.0);
}