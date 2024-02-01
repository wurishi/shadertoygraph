void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float value = sin(iTime*3.0 + uv.x) * 0.8 + 2.0;
	fragColor = texture(iChannel0, vec2(uv.x * value * 0.8, value * uv.y)).rgba;
}