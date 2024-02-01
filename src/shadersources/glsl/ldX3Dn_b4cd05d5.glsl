void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = -1.0 + 2.0*fragCoord.xy / iResolution.xy;
	
	float r = sqrt(dot(uv,uv));
	float a = atan(uv.x,uv.y);
	float s = 0.5 + 0.1*sin(10.0*a)*sin(iTime);
	if(r > s)
		r = 1.0;
	fragColor = mix(vec4(sin(iTime*2.0),cos(iTime*2.0),0,1),vec4(1.0),r);
}