void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = iTime * 0.5;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float aspect = iResolution.x / iResolution.y;
	
	mat3 xform = mat3(cos(sin(t)), sin(t  *0.25), 0.0,
					  -sin(t * 0.25), cos(cos(t)), 0.0,
					  cos(t / 2.0) * 0.2, sin(t) * 0.2, 1.0);
	
	uv = (xform * vec3(uv, 1.0)).xy * vec2(aspect, 1.0);
	
	uv.x -= sin(t) + cos(t * 2.0 + cos(uv.x) * sin(t * 2.0) * 2.0) / 2.0;
	uv.y += cos(t + uv.y * 0.5) + sin(uv.y * cos(t)) + sin(cos(t * 0.5) * length(uv));
	
	vec3 color = texture(iChannel0, uv).xyz;
	
	fragColor.xyz = color;
	fragColor.w = 1.0;
}