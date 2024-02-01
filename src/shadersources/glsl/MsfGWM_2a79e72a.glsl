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

float getSpiral(vec2 uv, float t) {
	float thickness = 15.0;
	uv = uv * 2.0 - vec2(1.0, 1.0); // -1 .. +1
	float d = length(uv); // distance from center
	float angle = degrees(atan(uv.y, uv.x)); // angle from center	
	return step(mod(angle + t + thickness * log(d), 30.0), thickness);
}

float getBalls(vec2 uv, float t, vec2 mid, float d) {
	float n = 300.0 + sin(t+dist(uv,mid)) * 10.0;
	float c = getSin(uv.x * n, 1.0, 1.0, 0.0) + getCos(uv.y * n, 1.0, 1.0, 0.0);
	return c;	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 mid = vec2(0.5,0.5);	
	float d = dist(uv, mid);
	float t = iTime;

	float c = getBalls(uv, t, mid, d);
	c *= getSpiral(uv, t * 20.0);
	fragColor = vec4(c,0.2+d*0.8,0.0,1.0);
}