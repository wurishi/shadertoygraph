void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y += (sin((uv.x + (iTime * 0.5)) * 10.0) * 0.1) + 
		(sin((uv.x + (iTime * 0.2)) * 32.0) * 0.01);
	vec4 texColor = texture(iChannel0, uv);
	fragColor = texColor;
}