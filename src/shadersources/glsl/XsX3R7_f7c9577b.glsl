void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
	vec2 pos = fragCoord.xy;
	vec2 uv2 = vec2( fragCoord.xy / iResolution.xy );
	vec4 sound = texture( iChannel1, uv2 );
	pos.x = pos.x + 150.0 * sound.r;
	pos.y = pos.y + 150.0 * sound.b;
	vec2 uv = pos / iResolution.xy;
	
	
	
	
	vec4 col = texture( iChannel0, uv );
	
	
	col.a += 1.0 - sin( col.x - col.y + iTime * 0.1 );
	
	
	fragColor =  col * sound.r;
}