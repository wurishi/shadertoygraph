#define AMPLIFER 2.0

vec4 getPixel(in int x, in int y, in vec2 fragCoord)
{
	return texture(iChannel0, (fragCoord.xy + vec2(x, y)) / iResolution.xy);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 sum = abs(getPixel(0, 1, fragCoord) - getPixel(0, -1, fragCoord));
	sum += abs(getPixel(1, 0, fragCoord) - getPixel(-1, 0, fragCoord));
	sum /= 2.0;
	vec4 color = getPixel(0, 0, fragCoord);
	color.g += length(sum) * AMPLIFER;
	fragColor = color;
}
