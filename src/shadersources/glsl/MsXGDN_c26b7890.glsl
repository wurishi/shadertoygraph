// not really a quasi crystal

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 uv = fragCoord.xy / iResolution.xy;
		
	float frequency = 0.02;  // effective zoom level higher to zoom out
	float gray = 0.0;
	
	// const fix for linux: http://www.khronos.org/webgl/public-mailing-list/archives/1012/msg00063.html
	const int waves = 7;
	
	float degrees = 180.0 / float(waves);	
	
	float normalization_factor = 1.0 / (1.0 + float(waves));
	
	for (int index = 0; index < waves; index++) {		
		gray += normalization_factor + normalization_factor * 
				 tan(
					cos(float(index) * radians(degrees)) * (fragCoord.x - 0.5 * iResolution.x) * frequency
				  + sin(float(index) * radians(degrees)) * (fragCoord.y - 0.5 * iResolution.y) * frequency
				  + iTime);		
	}
	
	fragColor = vec4(vec3(gray), 1.0);
}
