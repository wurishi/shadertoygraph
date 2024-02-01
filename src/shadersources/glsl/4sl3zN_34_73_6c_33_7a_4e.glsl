float rings(vec2 p)
{
	vec2 p2 = mod(p * 8.0, 4.0) - 2.0;
	
	if(p.x > -0.25){
    	return sin(length(p2) * 16.0 - iTime);
	}else{
		return sin(length(p2) * 16.0 + iTime);
	}
}
 
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 pos = (fragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
	fragColor = vec4(rings(pos) / 2.0, rings(pos) * 2.0, rings(pos), rings(pos));
}