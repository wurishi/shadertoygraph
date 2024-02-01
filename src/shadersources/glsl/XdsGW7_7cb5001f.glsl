void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec2 p = abs(cos(uv * 13.0));
	
	fragColor = vec4(sin (0.2 * iTime + sin(p * 0.5) * iTime / cos(50.0)) * 10.0,0.3+0.5 * abs(sin(iTime * tan(5.0))),1.0);
}