void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / sin(0.5 * iTime) / iResolution.xy;
	
	vec2 p = sin(2.0 * uv - 1.0);
	
	float gt = sin(3.0 * iTime);
	
	p *= abs(sin(p.x * gt) * tan(iTime));
	p /= abs(sin(p.y / sin(4.0 * iTime)));
	p *= abs(sin(p.x * cos(iTime)));
	p /= tan(abs(sin(p + gt)*3.0));
	
	fragColor = vec4(0.3,0.3,0.3,1.0);
	
	float scanline1 = abs(sin(10.0 * iTime + p.y * 14.0));
	scanline1 = abs(sin(scanline1));
	
	float scanline2 = abs(sin(11.0 * iTime + p.x * 10.0));
	scanline2 = abs(sin(scanline2));
	
	fragColor.y = scanline1 * 0.3;
	fragColor.y += scanline2 * 0.2;
}