// Horizontal lines transforming into blurry and colorful vertical lines

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float PI = 3.14159265358;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float screenRatio = iResolution.x / iResolution.y;
	
	vec3 color = vec3(
		cos(uv.x * 10. * PI * screenRatio) +
		cos(uv.y * 10. * PI) * abs(tan(iTime)));
	
	color.r += uv.x;
	color.g += uv.y;
	color.b += 1. - uv.y;
	
	fragColor = vec4(color, 1.0);
}
