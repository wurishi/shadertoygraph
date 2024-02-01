vec2 getModifiedUV(vec2 actualUV, vec2 pointUV, float radius, float strength)
{
	vec2 vecToPoint = pointUV - actualUV;
	float distToPoint = length(vecToPoint);
	
	float mag = (1.0 - (distToPoint / radius)) * strength;
	mag *= step(distToPoint, radius);
	
	return actualUV + (mag * vecToPoint);
	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	const float radius = 0.4;
	float strength = 0.5;
	
	float minRes = min(iResolution.x, iResolution.y); 
	vec2 uv = fragCoord.xy / minRes;
	vec2 pos = vec2(
		mod(iTime, (iResolution.x / minRes) + (radius * 2.0)) - radius,
		0.5 + 0.2 * cos(iTime)
	);
	
	// Uncomment this line to control with the mouse.
	//pos = iMouse.xy / min(iResolution.x, iResolution.y);
	
	vec2 modifiedUV = getModifiedUV(
		uv,
		pos,
		radius,
		strength );
		

	fragColor = texture(iChannel0, modifiedUV);
}