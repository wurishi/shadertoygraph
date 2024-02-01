void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float i, j;
	vec2 circ1, circ2;
	
	circ1.x = fragCoord.x-((sin(iTime)*iResolution.x)/4.0 + iResolution.x/2.0);
	circ1.y = fragCoord.y-((cos(iTime)*iResolution.x)/4.0 + iResolution.y/2.0);

	circ2.x = fragCoord.x-((sin(iTime*0.92+1.2)*iResolution.x)/4.0 + iResolution.x/2.0);
	circ2.y = fragCoord.y-((cos(iTime*0.43+0.3)*iResolution.x)/4.0 + iResolution.y/2.0);
	
	circ1.xy /= 16.0;
	circ2.xy /= 16.0;
	
	i = mod(sqrt(circ1.x*circ1.x+circ1.y*circ1.y),2.0) < 1.0 ? 0.0 : 1.0;
	j = mod(sqrt(circ2.x*circ2.x+circ2.y*circ2.y),2.0) < 1.0 ? 0.0 : 1.0;

	fragColor = vec4(j,i,0.0,1.0);
}