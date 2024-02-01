void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float stripeCount = 8.0 + 0.8*iResolution.y*sin(0.1*iTime);
	float stripeWidth = iResolution.y / (2.0*stripeCount);
	
	if(mod(fragCoord.y, 2.0*stripeWidth) > stripeWidth)
	{
		fragColor = vec4(1.0, 1.0, 1.0,1.0);
	}
	else
	{
		fragColor = vec4(0.0, 0.0, 0.0,1.0);
	}
}