void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float w = (0.5 - (uv.x)) * (iResolution.x / iResolution.y);
    float h = 0.5 - uv.y;
	float distanceFromCenter = sqrt(w * w + h * h);
	
	float sinArg = distanceFromCenter * 10.0 - iTime * 10.0;
	float slope = cos(sinArg) ;
	vec4 color = texture(iChannel0, uv + normalize(vec2(w, h)) * slope * 0.05);
	
	fragColor = color;
}