void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 britneyColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
	vec4 audreyColor  = texture(iChannel1, fragCoord.xy / iResolution.xy);
	
	//fragColor = britneyColor + audreyColor;
	
	if(   britneyColor.r < 0.4
	   && britneyColor.g > 0.4
	   && britneyColor.b < 0.5)
	{
		fragColor = audreyColor;
	}
	else
	{
		fragColor = britneyColor;
	}
}