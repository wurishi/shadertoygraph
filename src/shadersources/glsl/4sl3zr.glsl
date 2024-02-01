void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float threshold = iMouse.x / iResolution.x; 
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 c = texture(iChannel0, uv);
    
    float i = dot(c.rgb, vec3(0.3, 0.59, 0.11));
    
    float it = i > threshold ? 1.0 : 0.0;
    float error = abs(it - i);
    
	//fragColor = vec4(vec3(i), 1);
    fragColor = vec4(vec3(it), 1);
}