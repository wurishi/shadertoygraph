void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2	pos = fragCoord.xy / iResolution.xx;
	
	
	// destiny
	pos *= 40.0;
	
		
	// center of trunk	
    pos += vec2(10.0, 10.0);
	
	float	x;
	
    x = sqrt(pos.x * pos.x + pos.y * pos.y);	
    x = fract(x);
    
	// colors
	vec3	cl = mix(vec3(0.88, 0.72, 0.5), vec3(0.76, 0.54, 0.26), x);
		 
	fragColor = vec4(cl.x, cl.y, cl.z, 1.0);
}