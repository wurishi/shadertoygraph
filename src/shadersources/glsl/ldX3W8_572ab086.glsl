#ifdef GL_ES  
precision highp float;  
#endif  



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy);
	
	vec4 soundWave =  texture(iChannel0, uv * 0.5);
	
	float timeScroll = iTime* 1.0;
	float sinusCurve = sin((uv.x*2.0+timeScroll)/0.5)*0.3*soundWave.x;
	
	uv = (uv*2.-1.00) + vec2(0.0, sinusCurve);
	
	float line = abs(0.1 /uv.y);
	
	vec3 color = vec3(sin(iTime)*line,cos(iTime)*line,sin(iTime)*cos(line));
	
	fragColor = vec4(color, 0.0);
}