float bw(vec2 coords) {
	vec4 lm = texture(iChannel0, coords) * vec4(0.21, 0.71, 0.07, 1);
	
	return lm.r+lm.g+lm.b;	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.x = 1.0 - uv.x; // mirror image, thx @porglezomp
	
	vec2 of = vec2(1.0 / 128.0, 0);
	
	float bwColor = sqrt(
		pow(abs(bw(uv) - bw(uv+of.xx)), 2.0) +
		pow(abs(bw(uv + of.xy) - bw(uv + of.yx)), 2.0)
	);
	
	
	fragColor = vec4(bwColor);
}