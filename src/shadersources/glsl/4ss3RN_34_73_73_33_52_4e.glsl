void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float v = smoothstep(-0.02, 0.02, 0.2 - 0.1 * sin(30.0 * uv.x) - uv.y);
	fragColor = vec4(v, v, v, 1.0);
}