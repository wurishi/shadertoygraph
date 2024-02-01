const float Pi = 3.14159;
float beat = 0.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float ct = iChannelTime[0];
	if ((ct > 8.0 && ct < 33.5)
	|| (ct > 38.0 && ct < 88.5)
	|| (ct > 93.0 && ct < 194.5))
		beat = pow(sin(ct*3.1416*3.78+1.9)*0.5+0.5,15.0)*0.1;
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 p=(2.0*fragCoord.xy-iResolution.xy)/max(iResolution.x,iResolution.y);
	
	for(int i=1;i<40;i++)
	{
		vec2 newp=p;
		newp.x+=0.5/float(i)*cos(float(i)*p.y+beat+iTime*cos(ct)*0.3/40.0+0.03*float(i))+10.0;		
		newp.y+=0.5/float(i)*cos(float(i)*p.x+beat+iTime*ct*0.3/50.0+0.03*float(i+10))+15.0;
		p=newp;
	}
	
	vec3 col=vec3(0.5*sin(3.0*p.x)+0.5,0.5*sin(3.0*p.y)+0.5,sin(p.x+p.y));
	//col -= mod( fragCoord.y, 2.0 ) < 1.0 ? 0.5 : 0.0;
	fragColor=vec4(col, 1.0);
	
}