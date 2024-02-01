void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float b = texture(iChannel0, vec2(0.1, 0.0)).x;
	b = b*b;
	float c = texture(iChannel0, vec2(0.2, 0.0)).x;
	c = c*c;
	float d = texture(iChannel0, vec2(0.3, 0.0)).x;
	d = d*d;
	float e = texture(iChannel0, vec2(0.05, 0.0)).x * 5.0;
	
	float a = length(vec2(.5,.5)-uv);
	float angle = atan(uv.y,uv.x)*(6.0+e);
	a = a*(cos(angle+b+c+d+iTime)*0.5+1.0);
		
	vec4 col = texture(iChannel0, vec2(a, 0.0));
	col.x += b;
	col.y += c;
	col.z += d;
	fragColor = col;
}