float SPOT_SIZE = 300.0;
float BUMP_STRENGTH = 2.0;
float SPOT_BRIGHTNESS = 1.3;

vec4 HEIGHT_VECTOR = vec4(1.0/3.0, 1.0/3.0, 1.0/3.0, 0.0);

float getHeight(sampler2D channel, vec2 offset) {
	return dot(texture(channel, offset / iResolution.xy), HEIGHT_VECTOR);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// get "height" of adjucent pixels based on their brightness
	float upHeight = getHeight(iChannel1, fragCoord.xy + vec2(0,-1));
	float bottomHeight = getHeight(iChannel1, fragCoord.xy + vec2(0,+1));
	float leftHeight = getHeight(iChannel1, fragCoord.xy + vec2(-1,0));
	float rightHeight = getHeight(iChannel1,fragCoord.xy + vec2(1,0));
	
	// calculate normal vector
	float dx = (rightHeight - leftHeight) * BUMP_STRENGTH;
	float dy = (bottomHeight - upHeight) * BUMP_STRENGTH;
	float dz = sqrt (1.0 - dx*dx - dy*dy);	
	vec3 normal = vec3(dx,dy,dz);
	
	// get "light" vector based on mouse position
	vec2 mouse = iMouse.xy - fragCoord.xy;
	
	// dot product of normal and light
	float bumpMultiplier = dot(normal, vec3(mouse/iResolution.y,1.0));
	
	// spot light multiplier
	float spotMultiplier = min(exp(1.0-length(mouse)/SPOT_SIZE), SPOT_BRIGHTNESS);
	
	// output
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 color = texture(iChannel0, uv);
	fragColor = color * bumpMultiplier * spotMultiplier;

}