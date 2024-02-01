const float PI = 3.14;
const float stripes = 40.0;
const float waves = 30.0;

float luma(vec3 color)
{
	return dot(vec3(1.), vec3(0.213, 0.715, 0.072) * color);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;

	float wobble = 0.5 * sin(uv.y * stripes * PI * 2.0 + cos(uv.x * PI * 2.0 * waves));
	float result = smoothstep(0.3, 0.7, wobble + luma(texture(iChannel0, uv).rgb));
	
	fragColor = vec4(vec3(result), 1.);
}
