void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
	float 	centerBuffer 		= 0.15,
			vignetteStrength 	= 0.6,
			aberrationStrength 	= 1.25;
	
	float 	chrDist,
			vigDist;
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	//calculate how far each pixel is from the center of the screen
	vec2 vecDist = uv - (0.5, 0.5);
	chrDist = vigDist = length(vecDist);
	
	//modify the distance from the center, so that only the edges are affected
	chrDist	-= centerBuffer;
    chrDist = max(chrDist, 0.0);
	
	//distort the UVs
	vec2 uvR = uv * (1.0 + chrDist * 0.02 * aberrationStrength);
	vec2 uvB = uv * (1.0 - chrDist * 0.02 * aberrationStrength);
	
	//get the individual channels using the modified UVs
	vec4 c;
	
	c.x = texture(iChannel0 , uvR).x; 
	c.y = texture(iChannel0 , uv).y; 
	c.z = texture(iChannel0 , uvB).z;
	
	//apply vignette
	c *= 1.0 - vigDist * vignetteStrength;
	
	fragColor = c;
}