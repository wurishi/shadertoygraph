float cube(vec3 pos)
{
	return length(max(abs(pos) - vec3(18.0), 1.));
}

float map(vec3 pos)
{
	return cube(mod(pos - vec3(-5.0, 0.0, -iTime * 100.0), 50.0)
				 - vec3(25.));
}

vec3 traceRay(vec3 pos, vec3 dir)
{
   for (int i = 0; i < 42; i++)
   {
       float distance = map(pos);
       pos += 0.9 * distance * dir;
   }
	
   return pos;
}

vec3 calcNormal(vec3 pos)
{
    float eps = .01;
	
    return normalize(vec3(
		map(vec3(pos.x + eps, pos.y, pos.z)) - map(vec3(pos.x - eps, pos.y, pos.z)),
    	map(vec3(pos.x, pos.y + eps, pos.z)) - map(vec3(pos.x, pos.y - eps, pos.z)),
    	map(vec3(pos.x, pos.y, pos.z + eps)) - map(vec3(pos.x, pos.y, pos.z - eps))
	));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec3 pos = vec3(16. + sin(iTime) * 10., 0., 0.);
	vec3 dir = normalize(vec3(
		(fragCoord.x - iResolution.x * 0.5) / iResolution.y, fragCoord.y / iResolution.y - 0.5,
		1.0));
	vec3 color = vec3(.4, 0., 9.);
    vec3 point = traceRay(pos, dir);
    vec3 normal = calcNormal(point);
	
	float fogFactor = 1.0 - (1.0 / exp(point.z * 0.0005));
    float diffuse = max(dot(normal, vec3(9, .9, .0)), 0.0);
	
    color = mix(color * diffuse, vec3(1.), fogFactor);
	
	fragColor = vec4(color,1.0);
}