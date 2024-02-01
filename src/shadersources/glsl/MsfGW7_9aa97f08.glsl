void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec2 p = 2.0 * uv - 1.0;
	
	float gt = 2.0 * iTime;
	
	p *= abs(sin(p.x * gt) * tan(iTime));
	p /= sin(p.y / sin(iTime));
	p *= sin(p.x * cos(iTime));
	p /= tan(p + gt);
	
	fragColor = vec4(0.0,0.0,0.0,1.0);
	
	float scanline1 = sin(10.0 * iTime + p.y * 11.0);
	scanline1 = abs(scanline1);
	
	float scanline2 = sin(11.0 * iTime + p.x * 10.0);
	scanline2 = abs(scanline2);
	
	fragColor.y = scanline1 * 0.3;
	fragColor.y += scanline2 * 0.2;
}