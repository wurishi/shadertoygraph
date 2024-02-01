void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// how often do we change the formation
	float changeRatio = 1.0;
	
	float spikes = 1.0 + mod(floor(iTime * changeRatio), 4.0);
	float timeSinceChange = iTime * changeRatio - floor(iTime * changeRatio);
	
	vec2 screenCoord = fragCoord.xy / iResolution.xy;
	float aspectRatio = iResolution.x / iResolution.y;
	
	screenCoord.x *= aspectRatio;

	screenCoord -= vec2(0.5 * aspectRatio, 0.5);

	float angle = iTime * 0.5;

	vec2 effectCoord = vec2(sin(angle) * screenCoord.y + cos(angle) * screenCoord.x, cos(angle) * screenCoord.y - sin(angle) * screenCoord.x);
	
	float pixAngle = atan(effectCoord.x, effectCoord.y);
	float uvScale = sin(pixAngle * spikes);
	
	float scaleFactor = 0.25 + 0.25 * sin(iTime);
	
	effectCoord.r *= (1.0 - scaleFactor) + scaleFactor * uvScale;
	effectCoord.g *= (1.0 - scaleFactor) + scaleFactor * uvScale;
	
	float alpha = 10.0 * effectCoord.x * effectCoord.x * effectCoord.y * effectCoord.y; 
	alpha = min(alpha, 1.0);
	alpha = pow(alpha, 0.25);

	effectCoord.r += iTime * 0.3;
	effectCoord.g -= iTime * 0.2;
	
	
	float flashFactor = 1.0 - min(pow(timeSinceChange, 0.125), 1.0);
	
	vec2 coord0 = effectCoord + 0.1 * vec2(flashFactor * sin(angle), flashFactor * cos(angle));
	vec2 coord1 = effectCoord + 0.1 * vec2(flashFactor * sin(angle * 2.0), flashFactor * cos(angle * 2.0));
	vec2 coord2 = effectCoord + 0.1 * vec2(flashFactor * sin(angle * 1.5), flashFactor * cos(angle * 1.5));

	
	vec4 color = vec4(texture(iChannel0, coord0).r, texture(iChannel0, coord1).g, texture(iChannel0, coord2).b, 1.0);

	color.rgb = vec3(1.0, 1.0, 1.0) * flashFactor + (1.0 - flashFactor) * color.rgb;
	
	color.a = alpha;
	
	fragColor = vec4(color);
}