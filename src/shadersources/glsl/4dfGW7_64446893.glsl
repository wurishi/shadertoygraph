void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float c = 0.0;
	const float nLine = 30.0;
	for(float i=0.0 ; i<nLine ; i++)
	{
		float l = (i/nLine)*(iResolution.x+10.0);
		float lv = (i/nLine)*(iResolution.y+10.0);
		float forceStrength = 3000.0/distance(iMouse.xy,fragCoord.xy);
		float forceDir = sign(l-fragCoord.x);
		l += forceDir*forceStrength;
		lv = 1.0*forceStrength;
		c += 2.7/abs(fragCoord.x-l);
		c += 0.7/abs(fragCoord.y-lv);
	}
	
	fragColor = vec4(0.445*c,0.547*c,0.214*c,1.0);
}