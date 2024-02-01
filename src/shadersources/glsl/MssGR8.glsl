float gray(vec4 color)
{
	return (color.r + color.g + color.b) / 3.0;
}
	
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float pixelwide = 1.0 / iResolution.x;
    float pixelhigh = 1.0 / iResolution.y;

	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 c = texture(iChannel0, uv);
	float c_value = gray(c);
	
	vec4 l = texture(iChannel0, uv + vec2(-pixelwide, 0.0));
	vec4 u = texture(iChannel0, uv + vec2(0.0, pixelhigh));
	vec4 r = texture(iChannel0, uv + vec2( pixelwide, 0.0));
	vec4 b = texture(iChannel0, uv + vec2(0.0, -pixelhigh));
	
	float difference = 0.0;
	
	difference = max(difference, abs(c_value - gray(l)));
	difference = max(difference, abs(c_value - gray(u)));
	difference = max(difference, abs(c_value - gray(r)));
	difference = max(difference, abs(c_value - gray(b)));
	
	difference *= 20.0;
	
	fragColor = vec4(difference, difference, difference, 1.0);
}