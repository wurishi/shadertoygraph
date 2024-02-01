void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = mod(iTime, 1.0) / 1.0;
	float tn = t;
	if(tn > 0.5) {
		tn = 1.0 - t;
	}
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 m = iMouse.xy / iResolution.xy;
	float distX = max(0.0, 0.5 - distance(m.x, uv.x)/t );
	float distY = max(0.0, 0.5 - distance(m.y, uv.y)/t );
	uv.x = uv.x + sin((uv.y + t * 0.2) * 100.0) * pow(distY,2.0) * pow(distX, 2.0) * tn;
	vec4 color = texture(iChannel0, uv);

	fragColor = color;
}