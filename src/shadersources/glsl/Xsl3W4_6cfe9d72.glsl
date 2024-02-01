/*
  Andor Salga
  June 2013

  Click and drag to look around
*/

#if GL_ES
precision mediump float;
#endif

#define TAU 3.14159265894 * 2.0

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	// p will range from -1 to 1
	vec2 p = fragCoord.xy / iResolution.xy * 2.0 - 1.0;
	
	p.x *= iResolution.x / iResolution.y;
	
	vec2 cursor = iMouse.xy/iResolution.xy * 2.0 - 1.0;
	p += cursor;
	
	float pLength = length(p);
	
	// Use polar coordinate to sample the texture
	vec2 texel = vec2( 1.0/pLength + iTime * 0.3, atan(p.y/p.x)/TAU);
	

    vec4 fogCol = vec4(vec3(0.75) * pLength/2.0, 1.0);

	fragColor = texture(iChannel0, texel) * fogCol;
}