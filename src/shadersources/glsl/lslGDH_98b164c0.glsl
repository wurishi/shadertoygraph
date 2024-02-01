void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float h = 0.6 * texture(iChannel0, uv*0.1).r +
		      0.3 * texture(iChannel0, uv*0.2).r +
			  0.1 * texture(iChannel0, uv*0.4).r;
	
	float w = 40.0;
	vec3 n = normalize(vec3(dFdx(h) * w, dFdy(h) * w, 1.0));
	
	fragColor = vec4(n * 0.5 + 0.5,1.0);
}