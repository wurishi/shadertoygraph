float PI = 3.14159265358979323846;

float remap(float value, float inputMin, float inputMax, float outputMin, float outputMax)
{
    return (value - inputMin) * ((outputMax - outputMin) / (inputMax - inputMin)) + outputMin;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float w = (0.5 - (uv.x)) * (iResolution.x / iResolution.y);
    float h = 0.5 - uv.y;
	//æ¥µåº§æ¨™ç³»ã¸å¤‰æ›
	float distanceFromCenter = sqrt(w * w + h * h) + iTime * 0.5;
	float angle = remap(atan(h, w), -PI, PI, 0.0, 1.0);
	
	vec4 color = texture(iChannel0, vec2(angle, distanceFromCenter));
	
	fragColor = color;
}
