//utility
float remap(float value, float inputMin, float inputMax, float outputMin, float outputMax)
{
    return (value - inputMin) * ((outputMax - outputMin) / (inputMax - inputMin)) + outputMin;
}
float rand(vec2 n, float time)
{
  return 0.5 + 0.5 * 
     fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453 + time);
}

struct Circle
{
	vec2 center;
	float radius;
};
	
vec4 circle_mask_color(Circle circle, vec2 position)
{
	float d = distance(circle.center, position);
	if(d > circle.radius)
	{
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
	
	float distanceFromCircle = circle.radius - d;
	float intencity = smoothstep(
								    0.0, 1.0, 
								    clamp(
									    remap(distanceFromCircle, 0.0, 0.1, 0.0, 1.0),
									    0.0,
									    1.0
								    )
								);
	return vec4(intencity, intencity, intencity, 1.0);
}

vec4 mask_blend(vec4 a, vec4 b)
{
	vec4 one = vec4(1.0, 1.0, 1.0, 1.0);
	return one - (one - a) * (one - b);
}

float f1(float x)
{
	return -4.0 * pow(x - 0.5, 2.0) + 1.0;
}
	
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float wide = iResolution.x / iResolution.y;
	float high = 1.0;
	
	vec2 position = vec2(uv.x * wide, uv.y);
	
	Circle circle_a = Circle(vec2(0.5, 0.5), 0.5);
	Circle circle_b = Circle(vec2(wide - 0.5, 0.5), 0.5);
	vec4 mask_a = circle_mask_color(circle_a, position);
	vec4 mask_b = circle_mask_color(circle_b, position);
	vec4 mask = mask_blend(mask_a, mask_b);
	
	float greenness = 0.4;
	vec4 coloring = vec4(1.0 - greenness, 1.0, 1.0 - greenness, 1.0);
	
	float noise = rand(uv * vec2(0.1, 1.0), iTime * 5.0);
	float noiseColor = 1.0 - (1.0 - noise) * 0.3;
	vec4 noising = vec4(noiseColor, noiseColor, noiseColor, 1.0);
	
	float warpLine = fract(-iTime * 0.5);
	
	/** debug
	if(abs(uv.y - warpLine) < 0.003)
	{
		fragColor = vec4(1.0, 1.0, 1.0, 1.0);
		return;
	}
    */
	
	float warpLen = 0.1;
	float warpArg01 = remap(clamp((position.y - warpLine) - warpLen * 0.5, 0.0, warpLen), 0.0, warpLen, 0.0, 1.0);
	float offset = sin(warpArg01 * 10.0)  * f1(warpArg01);
	
	
	vec4 lineNoise = vec4(1.0, 1.0, 1.0, 1.0);
	if(abs(uv.y - fract(-iTime * 19.0)) < 0.0005)
	{
		lineNoise = vec4(0.5, 0.5, 0.5, 1.0);
	}
	
	vec4 base = texture(iChannel0, uv + vec2(offset * 0.02, 0.0));
	fragColor = base * mask * coloring * noising * lineNoise;

}