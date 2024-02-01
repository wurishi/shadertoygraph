float antiVignette(vec2 pos)
{
	return sqrt(abs(pos.x - .5)) + sqrt(abs(pos.y - .5));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec3 texture = texture(iChannel0, uv).rgb;
	
	float dBlack = 2. - abs(sin(1. - iTime * .5)) * 2.0;
	float dWhite = dBlack * .95;
	
	vec3 black = mix(vec3(1.), vec3(0.), clamp(floor(antiVignette(uv) / dBlack), .0, 1.));
	vec3 white = mix(vec3(1.), vec3(0.), clamp(floor(antiVignette(uv) / dWhite), .0, 1.));
	
	vec3 color = mix(vec3(.8), texture, white);
	color = mix(vec3(0.), color, black);
	
	fragColor = vec4(color, 1.0);
}
