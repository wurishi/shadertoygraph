/* Simple hue rotation filter based on article:
http://beesbuzz.biz/code/hsv_color_transforms.php
*/

#define SPEED 10.0

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float c = cos(iTime*SPEED);
	float s = sin(iTime*SPEED);
	
	mat4 hueRotation =	
					mat4( 	 0.299,  0.587,  0.114, 0.0,
					    	 0.299,  0.587,  0.114, 0.0,
					    	 0.299,  0.587,  0.114, 0.0,
					   		 0.000,  0.000,  0.000, 1.0) +
		
					mat4(	 0.701, -0.587, -0.114, 0.0,
							-0.299,  0.413, -0.114, 0.0,
							-0.300, -0.588,  0.886, 0.0,
						 	 0.000,  0.000,  0.000, 0.0) * c +
		
					mat4(	 0.168,  0.330, -0.497, 0.0,
							-0.328,  0.035,  0.292, 0.0,
							 1.250, -1.050, -0.203, 0.0,
							 0.000,  0.000,  0.000, 0.0) * s;
	
	vec4 pixel = texture(iChannel0, uv);

	fragColor = pixel * hueRotation;

}