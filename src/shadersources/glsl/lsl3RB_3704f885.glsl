#define iterations 100

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	//set the coordinates
	vec2 uv = fragCoord.xy / iResolution.xy * 3.0 - 1.5;
	uv.x -= .7;
	vec2 z = uv;
	vec2 c = z;
	float i = 0.0;
	//iterate the pixel
	for (int j = 0; j < iterations; ++j) {
		//if you're leaving, break
		if (length(c) > 2.0) break;
		//square the complex number
		c = vec2(c.x * c.x - c.y * c.y, c.x * c.y * 2.0);
		c += z;
		i += 1.0;
	}
	//color the pixel based on the escape time
	vec3 col;
	if (length(c) > 2.0) {
		col = mix(vec3(.1, 0, 0), vec3(1, .3, 0), i/float(iterations));
	} else {
		col = vec3(0);
	}
	fragColor = vec4(col, 1);
}