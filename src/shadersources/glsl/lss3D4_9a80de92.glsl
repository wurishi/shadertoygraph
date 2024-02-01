void mainImage( out vec4 fragColor, in vec2 c )
{
	vec2 p = c.xy / iResolution.xy;
	fragColor = texture(iChannel0, p+(texture(iChannel1, p).rb)*.1);
}