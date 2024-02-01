bool isInDarkVerticalStripe(float stripesCount, vec2 fragCoord)
{
	float stripeWidth = iResolution.x / (2.0*stripesCount);
	return (mod(fragCoord.x, 2.0*stripeWidth) > stripeWidth);
}

bool isInDarkHorizontalStripe(float stripesCount, vec2 fragCoord)
{
	float stripeWidth = iResolution.y / (2.0*stripesCount);
    return (mod(fragCoord.y, 2.0*stripeWidth) > stripeWidth);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float xStripesCount = 25.0 + 20.0*sin(1.2*iTime+0.5);
	float yStripesCount = 15.0 + 10.0*sin(1.8*iTime+0.4);
	
	float r = isInDarkVerticalStripe(xStripesCount,fragCoord) ? 1.0 : 0.0;
	float g = isInDarkHorizontalStripe(yStripesCount,fragCoord) ? 1.0 : 0.0;

    fragColor = vec4(r, g, 1.0,1.0);
}