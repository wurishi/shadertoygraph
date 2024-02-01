void mainImage( out vec4 fragColor, in vec2 fragCoord )
{	
	float stongth = sin(iTime) * 0.5 + 0.5;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float waveu = sin((uv.y + iTime) * 20.0) * 0.5 * 0.05 * stongth;
	fragColor = texture(iChannel0, uv + vec2(waveu, 0));
}