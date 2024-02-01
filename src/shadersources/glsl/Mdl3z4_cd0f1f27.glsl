const float kernelWidth = 3.;
const float kernelHeight = 3.;
const float kernelSize = kernelWidth * kernelHeight;

vec2 getUV(vec2 fragCoord) {
	return vec2(fragCoord.x / iResolution.x, fragCoord.y / iResolution.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	float kernel[(int(kernelWidth * kernelHeight))];
	kernel[0] = -1.;
	kernel[1] = -1.;
	kernel[2] = -1.;
	kernel[3] = -1.;
	kernel[4] =  8.;
	kernel[5] = -1.;
	kernel[6] = -1.;
	kernel[7] = -1.;
	kernel[8] = -1.;
	
	vec4 result = vec4(0.);
	vec2 uv = getUV(fragCoord);
	
	for(float y = 0.; y < kernelHeight; ++y) {
		for(float x = 0.; x < kernelWidth; ++x) {
			result += texture(iChannel0, vec2(uv.x + (float(int(x - kernelWidth / 2.)) / iResolution.x), 
												uv.y + (float(int(y - kernelHeight / 2.)) / iResolution.y)))
										   * kernel[int(x + (y * kernelWidth))];
		}
	}
	
	fragColor = result;
}