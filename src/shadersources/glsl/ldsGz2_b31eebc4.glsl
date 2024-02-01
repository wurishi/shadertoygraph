//enable webcam and move fingers or head in front of webcam
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float vX = fragCoord.x/iResolution.x;
	float vY = fragCoord.y/iResolution.y;
	float multiplier = sin(iTime/2.0)+80.0;
	vec2 vv = vec2(iResolution.x/multiplier,iResolution.y/multiplier);
	vec2 vg = vec2(sin(vX*vv.x),sin(vY*vv.y));
	vec4 v= texture(iChannel0,cos(vg));
	vec4 vs = texture(iChannel1,cos(vg)*2.0-1.0);
	fragColor = (4.0*v)*(vs/4.0);
}