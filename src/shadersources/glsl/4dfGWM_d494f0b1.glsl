const float fdelta = 2.0;
const float fhalf = 1.0;
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = -fragCoord.xy / iResolution.xy;

	float lum = length(texture(iChannel0, uv).rgb);
	
	fragColor = vec4(1.0, 1.0, 1.0, 1.0);
	
	if (lum < 1.00) {
		if (mod(fragCoord.x + fragCoord.y, fdelta) == 0.0) {
			fragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}
	
	if (lum < 0.75) {
		if (mod(fragCoord.x - fragCoord.y, fdelta) == 0.0) {
			fragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}
	
	if (lum < 0.50) {
		if (mod(fragCoord.x + fragCoord.y - fhalf, fdelta) == 0.0) {
			fragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}
	
	if (lum < 0.25) {
		if (mod(fragCoord.x - fragCoord.y - fhalf, fdelta) == 0.0) {
			fragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	}
}