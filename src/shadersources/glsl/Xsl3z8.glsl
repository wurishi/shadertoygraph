void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float phase=iTime*.5;//sin(iTime);
	float levels=8.;
	vec2 xy = fragCoord.xy / iResolution.xy;
	vec4 tx = texture(iChannel0, xy);
	
	//float x = (pix.r + pix.g + pix.b) / 3.0;//use this for BW effect.
	vec4 x=tx;
	
	x = mod(x + phase, 1.);
	x = floor(x*levels);
	x = mod(x,2.);
	
	fragColor= vec4(vec3(x), tx.a);
}