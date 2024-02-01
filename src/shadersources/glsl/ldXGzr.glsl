void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// We will use the mouse as base position.
	vec2 uv = (fragCoord.xy+iMouse.xy) / iResolution.xy;

	// iTime will scroll the result.
	fragColor = texture( iChannel0, iTime + (uv*4.0) );
}