void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	// Flip-a-roo.
	uv.y *= -1.0;
	
	// Represents the v/y coord(0 to 1) that will not sway.
	float fixedBasePosY = 0.0;
	
	// Configs for you to get the sway just right.
	float speed = 3.0;
	float verticleDensity = 6.0;
	float swayIntensity = 0.2;
	
	// Putting it all together.
	float offsetX = sin(uv.y * verticleDensity + iTime * speed) * swayIntensity;
	
	// Offsettin the u/x coord.
	uv.x += offsetX * (uv.y - fixedBasePosY);
	
	fragColor = texture(iChannel0, uv);
}