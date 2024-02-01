
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    const bool leftToRight = false;
    float slopeSign = (leftToRight ? -1.0 : 1.0);
    float slope1 = 5.0 * slopeSign;
    float slope2 = 7.0 * slopeSign;	
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	float bright = 
	- sin(uv.y * slope1 + uv.x * 30.0+ iTime *3.10) *.2 
	- sin(uv.y * slope2 + uv.x * 37.0 + iTime *3.10) *.1
	- cos(              + uv.x * 2.0 * slopeSign + iTime *2.10) *.1 
	- sin(              - uv.x * 5.0 * slopeSign + iTime * 2.0) * .3;
	
	float modulate = abs(cos(iTime*.1) *.5 + sin(iTime * .7)) *.5;
	bright *= modulate;
	vec4 pix = texture(iChannel0,uv);
	pix.rgb += clamp(bright / 1.0,0.0,1.0);
	fragColor = pix;
}