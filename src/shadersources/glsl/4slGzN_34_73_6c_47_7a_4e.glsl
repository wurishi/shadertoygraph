void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 lightBase = vec3(0.0, 0.0, 1.0);
	vec3 lightPos = vec3(0.5, 0.5, 1.0);
	
	vec3 lightVector = normalize(lightPos - vec3(fragCoord,0.) / iResolution);
	float c = max(0.0, dot(normalize(lightBase), lightVector));

	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 color = texture(iChannel0, uv);
	
    float d = pow(c / 3.0, 12.0 * (0.7 - c)) * cos(iTime);
    color =  vec4(color.r * d * 0.3, color.g * d * 0.3, color.b * d * 2.0, 1.0);
	
	fragColor = color;
}