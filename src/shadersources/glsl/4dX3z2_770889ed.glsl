void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = 1.0 - mod(iTime, 4.0) / 2.0;
	float tn = t;
	if(tn < 0.0) {
		tn = 0.000001;
		t = 0.000001;
	}
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 m = vec2(0.5, 0.5);
	float distX =  - distance(m.x, uv.x)/t;
	float distY =  - distance(m.y, uv.y)/t;
	uv.x = uv.x + sin((uv.y + t * 0.4) * 10.0) * distY * distX * tn;
	uv.y = uv.y + sin((uv.x + t * 0.4) * 10.0) * distY * distX * tn;
	vec4 color = texture(iChannel0, uv);

	fragColor = color;
}