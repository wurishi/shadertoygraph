void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec4 bump = texture(iChannel1, uv + iTime * 0.05);
	
	vec2 vScale = vec2 (0.01, 0.01);
	vec2 newUV = uv + bump.xy * vScale.xy;
	
	vec4 col = texture(iChannel0, newUV);
	
	fragColor = vec4(col.xyz, 1.0);
}