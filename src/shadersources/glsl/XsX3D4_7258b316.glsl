#define numLegs 3.0	//non integers look terrible
#define wibblewobble 6.5

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 p = -1.0+2.0*fragCoord.xy/iResolution.xy;
	
	float w = sin(iTime+wibblewobble*sqrt(dot(p,p))*cos(p.x)); 	//part 2
	float x = cos(numLegs*atan(p.y,p.x) + 1.8*w);	//part 1
	
	vec3 col = vec3(0.1,0.2,0.82)*15.0;

	fragColor = vec4(col*x,1.0);
	
}