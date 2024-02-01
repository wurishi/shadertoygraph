void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy/iResolution.xy;
	uv.y = -uv.y;
	vec4 up = texture(iChannel0, uv);
	uv.x = (fragCoord.x+1.0)/iResolution.x;
	uv.y = - ((fragCoord.y+1.0)/iResolution.y);
	vec4 down = texture(iChannel0, uv);
	fragColor = up - down;
}