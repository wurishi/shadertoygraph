

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy);
	uv.y = 1.0-uv.y;
	
	float time = iTime * 0.75;
		
	vec4 pixel2 = texture(iChannel1, (uv+vec2(sin(time),cos(time))) * 0.15  );
	
	float xDiff = pixel2.r * 0.02;
	float yDiff = 0.0;
	
	vec2 diffVec = vec2( xDiff, yDiff );
	
	vec4 pixel = texture(iChannel0, uv + diffVec);
	
	fragColor = pixel;
}