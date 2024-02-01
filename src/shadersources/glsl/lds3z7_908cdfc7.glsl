// Thanks to IQ for this hash idea :)
float hash( float n )
{
	return fract( sin(n)*54671.57391);
}

float noise( vec2 p )
{
	return hash( p.x + p.y * 57.1235 );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float n = noise( uv );
	fragColor = vec4(vec3(n),1.0);
}