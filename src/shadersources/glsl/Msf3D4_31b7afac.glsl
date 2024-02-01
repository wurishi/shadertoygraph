/*
  Andor Salga
  June 2013
*/

uniform sampler2D sampler0;

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec2 texCoords = fragCoord.xy / iResolution.xy;
	
	float mouseX;
	if(int(iMouse.x) == 0){
	  mouseX = iResolution.x/2.0;
	}
	else{
	  mouseX = iMouse.x;
	}
	
	float amp = mouseX / iResolution.x * 2.0;
	
	texCoords.xy += vec2(0, sin( iTime * 3.0 + fragCoord.x/50.0)/20.0 * amp);
	
	// Expand texture so even after wobble, the valleys from sin are off screen
	texCoords.xy *= 0.7;
	
	// Center the image
	texCoords.xy += (1.0 - 0.7)/2.0;
	
	// use if using simple texture
	//texCoords.y = 1.0 - texCoords.y;

	fragColor = texture(sampler0, texCoords);
}