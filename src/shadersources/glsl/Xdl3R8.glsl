void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 MapPixel = texture(iChannel0, uv);
	
	vec2 SrcCoord = MapPixel.rg;
	SrcCoord.y = 1. - SrcCoord.y;

	vec4 ResultPixel = texture(iChannel1, SrcCoord);
	
	ResultPixel.a = MapPixel.a;
	
	fragColor= ResultPixel;
}