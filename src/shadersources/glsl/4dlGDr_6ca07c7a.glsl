#define RADIUS  0.03
#define SAMPLES 20

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 sum = vec3(0);
		
	for (int i = -SAMPLES; i < SAMPLES; i++) {
		for (int j = -SAMPLES; j < SAMPLES; j++) {
			sum += texture(iChannel0, uv + vec2(i, j) * (RADIUS/float(SAMPLES))).xyz
				 / pow(float(SAMPLES) * 2., 2.);
		}
    }
	
	fragColor = vec4(sum, 1.0);
}