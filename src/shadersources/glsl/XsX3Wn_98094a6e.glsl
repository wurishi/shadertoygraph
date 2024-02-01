void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float distance = sqrt( pow(uv[0]-0.5, 2.0) + pow(uv[1]-0.5, 2.0) );
	float colour = sin(distance*iTime*100.0);
	fragColor = vec4(colour, colour, colour,1.0);
}