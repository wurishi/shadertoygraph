// http://en.wikipedia.org/wiki/Sobel_operator

mat3 gx = mat3(
	 1.0,  2.0,  1.0,
	 0.0,  0.0,  0.0,
	-1.0, -2.0, -1.0
);

mat3 gy = mat3(
	-1.0, 0.0, 1.0,
	-2.0, 0.0, 2.0,
	-1.0, 0.0, 1.0
);

vec3 edgeColor = vec3(1.0, 0.5, 0.75);

float intensity(vec3 pixel) {
	return (pixel.r + pixel.g + pixel.b) / 3.0;
}

float pixelIntensity(vec2 uv, vec2 d) {
	vec3 pix = texture(iChannel0, uv + d / iResolution.xy).rgb;
	return intensity(pix);
}

float convolv(mat3 a, mat3 b) {
	float result = 0.0;

	for (int i=0; i<3; i++) {
		for (int j=0; j<3; j++) {
			result += a[i][j] * b[i][j];
		}
	}

	return result;
}

float sobel(vec2 uv) {
	mat3 pixel = mat3(0.0);

	for (int x=-1; x<2; x++) {
		for (int y=-1; y<2; y++) {
			pixel[x+1][y+1] = pixelIntensity(uv, vec2(float(x), float(y)));
		}
	}

	float x = convolv(gx, pixel);
	float y = convolv(gy, pixel);

	return sqrt(x * x + y * y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 uv = fragCoord.xy / iResolution.xy;

	float time = iTime * 0.75;

	float x = 0.5 + sin(time) * 0.25;
	float y = 0.5 + cos(time) * 0.25;

	vec3 color = texture(iChannel0, uv).rgb;	
	float s = sobel(uv);

	// Top left
	if (uv.x < x && uv.y > y) {
		// original
	}
	// Bottom right
	else if (uv.x > x && uv.y < y) {
		color += edgeColor * s;
	}
	// Top right
	else if (uv.x > x && uv.y > y) {
		color = edgeColor * s;
	}
	// Bottom left
	else {
		color = edgeColor * (1.0 - s);
	}
	
	fragColor = vec4(color, 1.0);
}