const vec3 greyscale = vec3(.3, .6, .1);

//Scharr filter
//http://en.wikipedia.org/wiki/Sobel_operator#Alternative_operators
vec2 calcGradient(vec2 p) {
	vec2 dxy = vec2(1.) / iResolution.xy;
	vec2 dx = vec2(dxy.x, 0.);
	vec2 dy = vec2(0., dxy.y);
	//3x3 greyscale intensity window
	float i00 = dot(texture(iChannel0, p - dxy).rgb, greyscale);
	float i10 = dot(texture(iChannel0, p - dy).rgb, greyscale);
	float i20 = dot(texture(iChannel0, p - dy + dx).rgb, greyscale);
	float i01 = dot(texture(iChannel0, p - dx).rgb, greyscale);
	float i11 = dot(texture(iChannel0, p).rgb, greyscale);
	float i21 = dot(texture(iChannel0, p + dx).rgb, greyscale);
	float i02 = dot(texture(iChannel0, p - dx + dy).rgb, greyscale);
	float i12 = dot(texture(iChannel0, p + dy).rgb, greyscale);
	float i22 = dot(texture(iChannel0, p + dxy).rgb, greyscale);

	vec2 g;
	g.x = 3. * i02 + 10. * i12 + 3. * i22
			 - 3. * i00 - 10. * i10 - 3. * i20;
	g.y = 3. * i20 + 10. * i21 + 3. * i22
			 - 3. * i00 - 10. * i01 - 3. * i02;
	return g;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 dxy = vec2(1.) / iResolution.xy;
	vec2 pt = fragCoord.xy / iResolution.xy;
	vec2 grad = calcGradient(pt);
	
	fragColor = vec4(abs(normalize(vec3(grad, 1.))), 1.);
}