void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 xy = fragCoord.xy / iResolution.xy;
	float g = distance(xy, vec2(xy.x, pow(xy.x, 2.2)));
	float b = distance(xy, vec2(xy.x, xy.x < 0.04045 ? xy.x/12.92 : pow((xy.x+0.055)/1.055, 2.4)));
	fragColor = vec4(0.0, g < 0.0015, b < 0.0015, 1.0);
}