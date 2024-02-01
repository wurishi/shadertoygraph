#ifdef GL_ES  
precision highp float;  
#endif  


float bump(float x) {
	return abs(x) > 1.0 ? 0.0 : 1.0 - x * x;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy);
	
	float c = 3.0;
	vec3 color = vec3(1.0);
	color.x = bump(c * (uv.x - 0.75));
	color.y = bump(c * (uv.x - 0.5));
	color.z = bump(c * (uv.x - 0.25));
	
	uv.y -= 0.5;
	
	float line = abs(0.01 / uv.y);
	vec4 soundWave =  texture(iChannel0, uv * 0.3);
	
	// soundWave.y -> soundWave.x
	color *= line * (uv.x + soundWave.x * 1.5);
	
	
	fragColor = vec4(color, 0.0);
}