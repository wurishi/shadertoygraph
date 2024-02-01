float tile_num = 20.0;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    uv.y = (1.0-uv.y);
	uv = floor(uv*tile_num)/tile_num;
	fragColor = texture( iChannel0, uv );
}