#ifdef GL_ES
precision highp float;
#endif

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float scale = floor(abs(mod(iTime*0.25, 6.0)))*0.25 + 0.25;
	
	scale += sin(iTime*0.0001);
	
    vec2 pos = fragCoord.xy - 0.5 * iResolution.xy;
	
	float dist = pos.x*pos.x+pos.y*pos.y;
	
	float red   = sin(dist*0.1*scale+iTime)*0.5 + 0.5;
	float green = sin(dist*0.2*scale+iTime)*0.5 + 0.5;
	
	fragColor = vec4(red, green, 0.4, 1.0);
}