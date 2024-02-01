/*
  Andor Salga
  June 2013

  Click and drag to interact with shader.
*/

#define TWO_PI 3.141592658 * 2.0

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec2 cartCoords =  1.0 - 2.0 * fragCoord.xy / iResolution.xy;
		
	vec2 polarCoords = vec2( length(cartCoords), atan(cartCoords.y/cartCoords.x)/TWO_PI);
	
	vec2 blend = mix(cartCoords, polarCoords, iMouse.x/iResolution.x);
	
	vec3 texelCol = texture(iChannel0, blend).xyz;

	fragColor = vec4( texelCol, 1.);
}