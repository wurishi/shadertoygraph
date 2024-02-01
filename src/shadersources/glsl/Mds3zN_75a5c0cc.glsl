
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float i, j,d1, d2, l,s,distort;
	vec2 circ1, circ2;
	vec4 c,c1;
	
	
	distort = 50.0*sin(iTime*0.1);
	circ1.x = fragCoord.x-((sin(iTime)*iResolution.x)/4.0 + iResolution.x/2.0);
	circ1.y = fragCoord.y-((cos(iTime)*iResolution.x)/4.0 + iResolution.y/2.0);

	circ2.x = fragCoord.x-((sin(iTime*1.92+1.2)*iResolution.x)/4.0 + iResolution.x/2.0);
	circ2.y = fragCoord.y-((cos(iTime*1.43+0.3)*iResolution.x)/4.0 + iResolution.y/2.0);
	
	circ1.xy /= 24.0+sin(distort+iTime+circ1.y*0.015);
	circ2.xy /= 24.0+sin(distort-iTime+circ1.x*0.25);
	
	d1 = 1.5*sqrt(circ1.x*circ1.x+circ1.y*circ1.y);
	i = sin(d1)*0.5+0.5;
	
	d2 = 1.5*sqrt(circ2.x*circ2.x+circ2.y*circ2.y);
	j = sin(d2)*0.5+0.5;

	l = 75.0/(d1+d2);
	l *= l*l;
	l += 0.25+0.750*sin(iTime*0.1);
	
	s  = 0.5*sin(iTime*0.2)+0.5;
	
	c1 = (vec4(1.0,0.25,0.125,1.0)*(j+i))*(1.0-s);
	c = vec4(i*j, i*j, i*j, 0)*s;


	vec2 uv = fragCoord.xy / iResolution.xy - 0.5;
	float noise = 1.0;//0.2*sin(uv.y*800.0)+1.0-2.0*abs(uv.x);	
	
	fragColor = noise*(c+c1)*l;//*texture(iChannel0, sin(iTime*100.0)*vec2(fragCoord.x/iResolution.x,fragCoord.y/iResolution.y))*1.15;
}