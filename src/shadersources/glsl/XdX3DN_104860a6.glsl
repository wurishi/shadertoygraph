void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y = -uv.y;
	vec2 mouse = iMouse.xy / iResolution.xy;
	vec2 warp = normalize(iMouse.xy - fragCoord.xy) * pow(distance(iMouse.xy, fragCoord.xy), -2.0) * 30.0;
	warp.y = -warp.y;
	uv = uv + warp;
	
	float light = clamp(0.1*distance(iMouse.xy, fragCoord.xy) - 1.5, 0.0, 1.0);
	
	vec4 color = texture(iChannel0, uv);
	fragColor = color * light;
	
	
}