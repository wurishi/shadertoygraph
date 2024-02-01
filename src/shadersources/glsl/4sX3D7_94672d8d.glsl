float dist(vec2 p1, vec2 p2) {
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	return sqrt(dx * dx + dy * dy);	
}

float dotp(vec2 p1, vec2 p2) {
	return p1.x * p2.x + p1.y * p2.y;	
}

float getR(float h, float w) {
	return pow(cos(h*6.283185307179586476925286766559)*0.5+0.5,w);
}

float getG(float h, float w) {
	return pow(cos((h+1.0/3.0)*6.283185307179586476925286766559)*0.5+0.5,w);
}

float getB(float h, float w) {
	return pow(cos((h+2.0/3.0)*6.283185307179586476925286766559)*0.5+0.5,w);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float t = iTime;
	vec2 a = vec2(0.5,0.5);
	vec2 b = vec2(0.25,0.625);
	vec2 c = vec2(0.75,0.625);
	
	float d = cos(dist(uv,a)*17.0)+ cos(dist(uv,b)*15.0+t*0.2) + cos(dist(uv,c)*13.0+t*0.3);
	float q = cos(dist(uv-a,c)*4.3+dist(uv,b)*4.0+t*0.5)*2.0+2.2;

	fragColor = vec4(getR(d,q), getG(d,q), getB(d,q), 1.0);
}