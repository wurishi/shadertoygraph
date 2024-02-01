

bool isInsideSquare(vec2 center, float halfSide, vec2 fragCoord)
{
	return 
		   fragCoord.x > center.x - halfSide
	  && fragCoord.x < center.x + halfSide 
	  && fragCoord.y > center.y - halfSide
	  && fragCoord.y < center.y + halfSide;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float size = (0.1+0.4*abs(sin(iTime)))*iResolution.y;
	vec2 center = 0.5*iResolution.xy;
	center.x = mod(100.0*iTime, float(1.2*iResolution.x));
	
		
	if( isInsideSquare(center, size,fragCoord))
	{
		
	    fragColor = vec4(1.0, 0.0, 0.0, 1.0);
	}
	else
	{
		fragColor = vec4(1.0, 1.0, 1.0, 1.0);
	}	
}