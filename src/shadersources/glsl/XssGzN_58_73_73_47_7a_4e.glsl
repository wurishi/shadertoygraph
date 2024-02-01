void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 n = vec2(1.0) / iResolution.xy;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float x = uv.x - 0.5;
	float y = uv.y - 0.5;
	float z = 0.2 - x * x - y * y;
	
	float x2 = uv.x - n.x - 0.5;
	float y2 = uv.y - n.y - 0.5;
	float z2 = 0.2 - x2 * x2 - y2 * y2;
	
	z = sqrt(z) + 0.5 * cos(iTime);
	z2 = sqrt(z2) + 0.5 * cos(iTime);
	
	vec3 pos = vec3(x, y, z);
	vec3 pos2 = vec3(x2, y2, z2);
	vec3 normal = normalize(cross(pos, pos2));
	vec3 light = normalize(vec3(1.0, 0.0, 0.0));
	
	float c = dot(normal, light);
	
	fragColor = vec4(c * vec3(1.0, 0.0, 0.0), 1.0);
}