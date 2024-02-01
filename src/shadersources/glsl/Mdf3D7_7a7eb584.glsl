#define Distance 200.0

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 color = vec3(0.0, 0.0, 0.0);
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	
	
	color = vec3(uv,0.5+0.5*sin(iTime));
	
	vec2 texCoord1 = vec2(fragCoord.x-iResolution.x/2.0-sin(iTime)*Distance, fragCoord.y-iResolution.y/2.0-cos(iTime)*Distance);
	vec2 texCoord2 = vec2(fragCoord.x-iResolution.x/2.0+sin(iTime)*Distance, fragCoord.y-iResolution.y/2.0+cos(iTime)*Distance);

	vec2 texCoord3 = vec2(fragCoord.x-iResolution.x/2.0-sin(iTime)*Distance, fragCoord.y-iResolution.y/2.0+cos(iTime)*Distance);
	vec2 texCoord4 = vec2(fragCoord.x-iResolution.x/2.0+sin(iTime)*Distance, fragCoord.y-iResolution.y/2.0-cos(iTime)*Distance);
	
	float brightness1 = sqrt(pow(texCoord1.x, 2.0) + pow(texCoord1.y, 2.0));
	float brightness2 = sqrt(pow(texCoord2.x, 2.0) + pow(texCoord2.y, 2.0));
	
	float brightness3 = sqrt(pow(texCoord3.x, 2.0) + pow(texCoord3.y, 2.0));
	float brightness4 = sqrt(pow(texCoord4.x, 2.0) + pow(texCoord4.y, 2.0));
	
	float brightness = min((brightness1 + brightness2)/2.0, (brightness3 + brightness4)/2.0);
	
	
	fragColor = vec4((color+(sin(pow(brightness/80.0, 2.0)-iTime*4.0)/10.0)), 1.0);
}