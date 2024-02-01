void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.x =+ abs(sin(iTime * 9.0));
	fragColor = vec4(1.0 - uv + sin(uv.y * tan(iTime * 5.0) * iTime * 0.3 + uv.x * sin(iTime * 2.4) * 30.0),0.5+0.5*sin(iTime),1.0);
	uv.y =- abs(sin(iTime * 1.0));
}