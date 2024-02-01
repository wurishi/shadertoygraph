void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 britneyColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
	vec4 audreyColor  = texture(iChannel1, fragCoord.xy / iResolution.xy);
	vec4 chromeColor  = texture(iChannel2, fragCoord.xy / iResolution.xy);
	
	float ratio = (audreyColor.r + audreyColor.g + audreyColor.b)/3.0;
	fragColor = ratio * britneyColor + (1.0-ratio) * chromeColor;
}