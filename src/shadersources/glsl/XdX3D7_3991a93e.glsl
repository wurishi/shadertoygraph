float perspective = 0.3;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord.xy / iResolution.xy;
	float focus = sin(iTime*2.)*.35+.5;
	float blur = 7.*sqrt(abs(p.y - focus));
	
	/* perpective version */	
	//vec2 p2 = vec2(p.x-(1.-p.y)*perspective*(p.x*2. - 1.), -p.y);
	
	/* simple vesion */
	vec2 p2 = -p;	
	
	fragColor = texture(iChannel0, p2, blur);
}