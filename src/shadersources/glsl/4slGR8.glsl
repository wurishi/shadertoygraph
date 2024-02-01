const float pi  = 3.14159265359;
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
	vec2 coords = fragCoord.xy;
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	uv *= vec2(sin(iTime) / 6.0,1);
	fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
	fragColor = texture(iChannel0,uv);
	fragColor.r = sin(iTime);
	
}