

bool isInsideCircle(vec2 center, float radius, vec2 fragCoord)
{
	return distance(fragCoord.xy, center) < radius;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float radius = (0.1+0.4*abs(sin(iTime)))*iResolution.y;
	vec2 center = 0.5*iResolution.xy;
	center.x = mod(100.0*iTime, float(1.2*iResolution.x));
	
	if( isInsideCircle(center, radius,fragCoord))
	{	
	    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
	}
	else
	{
		fragColor = vec4(1.0, 1.0, 1.0, 1.0);
	}	
}