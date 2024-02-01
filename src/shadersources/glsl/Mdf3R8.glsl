void mainImage( out vec4 fragColor, in vec2 fragCoord )                             
{
	//NOTE: hold mouse down to make her move.
	vec2 lightPosition = iMouse.xy;
	float radius = 350.0;

    float distance  = length( lightPosition - fragCoord.xy );

    float maxDistance = pow( radius, 0.20);
    float quadDistance = pow( distance, 0.23);

    float quadIntensity = 1.0 - min( quadDistance, maxDistance )/maxDistance;

	vec4 texture = texture(iChannel0, fragCoord.xy / iResolution.xy);

	fragColor = texture * vec4(quadIntensity);
}