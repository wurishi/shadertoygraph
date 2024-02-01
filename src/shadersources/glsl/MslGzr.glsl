void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
	vec3 tex = texture( iChannel0, uv ).rgb;

    
    float freq = 300.;
    vec3 offs = vec3(0.0, 1.0/3.0, 2.0/3.0) * (2.0 * 3.14159265);
    
    vec3 scaler = sin(vec3(uv.x) * freq + offs);
    
	vec3 col = tex * scaler;
	
    fragColor = vec4(col,1.0);
}
