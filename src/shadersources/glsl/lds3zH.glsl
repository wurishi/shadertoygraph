float remap(float value, float inputMin, float inputMax, float outputMin, float outputMax)
{
    return (value - inputMin) * ((outputMax - outputMin) / (inputMax - inputMin)) + outputMin;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float transion = remap(sin(iTime * 1.0), -1.0, 1.0, -0.5, 1.2);
	float waveTransion = transion + sin(uv.y * 20.0) * 0.1;
	
	vec4 a = texture(iChannel0, uv);
	vec4 b = texture(iChannel1, uv);
	
	float blend = 0.2;
	float s = remap(clamp(uv.x - (waveTransion - blend * 0.5), 0.0, blend), 0.0, blend, 0.0, 1.0);
	
	fragColor = mix(a, b, smoothstep(0.0, 1.0, s));
}