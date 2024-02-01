void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 pt ;
	pt.x=300.+150.*cos(iTime*9.);
	pt.y=200.+100.*sin(iTime*4.) ;
	
	float dist = distance(pt,fragCoord.xy) ;
	if ( dist <= 60.) {
		fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
	} else {
		fragColor = vec4(0,0,0,1.0);
	}
}