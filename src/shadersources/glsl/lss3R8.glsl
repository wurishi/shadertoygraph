#define FILTER_SIZE 3
#define COLOR_LEVELS 7.0
#define EDGE_FILTER_SIZE 3
#define EDGE_THRESHOLD 0.05

vec4 edgeFilter(in int px, in int py, in vec2 fragCoord)
{
	vec4 color = vec4(0.0);
	
	for (int y = -EDGE_FILTER_SIZE; y <= EDGE_FILTER_SIZE; ++y)
	{
		for (int x = -EDGE_FILTER_SIZE; x <= EDGE_FILTER_SIZE; ++x)
		{
			color += texture(iChannel0, (fragCoord.xy + vec2(px + x, py + y)) / iResolution.xy);
		}
	}

	color /= float((2 * EDGE_FILTER_SIZE + 1) * (2 * EDGE_FILTER_SIZE + 1));
	
	return color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{	
	// Shade
	vec4 color = vec4(0.0);
	
	for (int y = -FILTER_SIZE; y <= FILTER_SIZE; ++y)
	{
		for (int x = -FILTER_SIZE; x <= FILTER_SIZE; ++x)
		{
			color += texture(iChannel0, (fragCoord.xy + vec2(x, y)) / iResolution.xy);
		}
	}

	color /= float((2 * FILTER_SIZE + 1) * (2 * FILTER_SIZE + 1));
	
	for (int c = 0; c < 3; ++c)
	{
		color[c] = floor(COLOR_LEVELS * color[c]) / COLOR_LEVELS;
	}
	
	// Highlight edges
	vec4 sum = abs(edgeFilter(0, 1, fragCoord) - edgeFilter(0, -1, fragCoord));
	sum += abs(edgeFilter(1, 0, fragCoord) - edgeFilter(-1, 0,fragCoord));
	sum /= 2.0;	

	if (length(sum) > EDGE_THRESHOLD)
	{
		color.rgb = vec3(0.0);	
	}
	
	fragColor = color;
}
