void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y = -uv.y;
	uv.x += (sin((uv.y + (iTime * 0.07)) * 45.0) * 0.009) +
		(sin((uv.y + (iTime * 0.1)) * 35.0) * 0.005);
		//0.0;
	
	vec4 texColor = texture(iChannel0,uv);
	fragColor = texColor;
}