float remap(float value, float inputMin, float inputMax, float outputMin, float outputMax)
{
    return (value - inputMin) * ((outputMax - outputMin) / (inputMax - inputMin)) + outputMin;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float normalizedContrast = sin(iTime) * 0.5 + 0.5;
	float contrast = remap(normalizedContrast, 0.0, 1.0, 0.2 /*min*/, 4.0 /*max*/);
	if(uv.y > 0.95)
	{
		fragColor = uv.x > normalizedContrast ? vec4(0.0, 1.0, 0.8, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
	}
	else	
	{
		vec4 srcColor = texture(iChannel0, uv);
		vec4 dstColor = vec4((srcColor.rgb - vec3(0.5)) * contrast + vec3(0.5), 1.0);
		fragColor = clamp(dstColor, 0.0, 1.0);
	}
}