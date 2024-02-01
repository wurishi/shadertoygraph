/*
    Andor Salga
    June 2013
*/

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 point = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
	
	vec2 texCoord = point;
	
	texCoord.y = abs(0.25/texCoord.y);
	texCoord.x *= texCoord.y;
	
	texCoord.y += iTime * 0.25;
	texCoord.x += iTime * 0.05;
	
	vec4 darkness = vec4(abs(point.y)) / 1.5;
	
	fragColor = texture(iChannel0, texCoord) * darkness;
}