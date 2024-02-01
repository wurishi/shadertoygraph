float dist(vec2 p1, vec2 p2) {
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	return sqrt(dx * dx + dy * dy);	
}

float sqmag(vec2 p) {
	return p.x * p.x + p.y * p.y;	
}

float dotp(vec2 p1, vec2 p2) {
	return p1.x * p2.x + p1.y * p2.y;	
}

float getR(float h) {
	return cos(h*6.283185307179586476925286766559)*0.5+0.5;
}

float getG(float h) {
	return cos((h+1.0/3.0)*6.283185307179586476925286766559)*0.5+0.5;
}

float getB(float h) {
	return cos((h+2.0/3.0)*6.283185307179586476925286766559)*0.5+0.5;
}

vec2 immul(vec2 p1, vec2 p2) {
	return vec2(p1.x*p2.x-p1.y*p2.y,p1.x*p2.y+p1.y*p2.x);	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 pp = fragCoord.xy / iResolution.xy - vec2(0.5,0.5);
	vec2 origin = vec2(0.0,0.0);
	float t = iTime;
	float c = 0.0;
	
	vec2 uv = pp * 3.0 * pow(0.8,t) - vec2(0.729,0.2014);
	
	vec2 tmp = uv;
	for(int i=0;i<65;i++){
		if(i==64){c=0.0;break;}
		tmp = immul(tmp,tmp)+uv;
		tmp = immul(tmp,tmp)+uv;
		c+=1.0/64.0;
		if(sqmag(tmp)>4.0)break;
	}
	
	fragColor = vec4(getR(c), getG(c), getB(c), 1.0);
}