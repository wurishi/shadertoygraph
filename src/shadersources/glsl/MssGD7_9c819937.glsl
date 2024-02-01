float spheres(vec3 pos, float r)
{
  return length(mod(pos, 30.0) - vec3(15.0)) - r;
}


float map(vec3 pos)
{
	return spheres(pos, ((1. + cos(iTime * 2.)) * 1.5));
}

vec3 traceRay(vec3 pos, vec3 dir)
{
   for (int i = 0; i < 24; i++)
   {
       float distance = map(pos);
       pos += 0.9 * distance * dir;
   }
	
   return pos;
}

vec3 calcNormal(vec3 pos)
{
    float eps = 0.01;
	
    return normalize(vec3(
		map(vec3(pos.x + eps, pos.y, pos.z)) - map(vec3(pos.x - eps, pos.y, pos.z)),
    	map(vec3(pos.x, pos.y + eps, pos.z)) - map(vec3(pos.x, pos.y - eps, pos.z)),
    	map(vec3(pos.x, pos.y, pos.z + eps)) - map(vec3(pos.x, pos.y, pos.z - eps))
	));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec3 pos = vec3(iTime * 50., sin(iTime) * 20., 0.);
	vec3 dir = normalize(vec3(
		(fragCoord.x - iResolution.x * 0.5) / iResolution.y, fragCoord.y / iResolution.y - 0.5,
		cos(iTime) * 1.5));
		//1.0));
	vec3 color = vec3(.9, 0., 0.);
    vec3 point = traceRay(pos, dir);
    vec3 normal = calcNormal(point);
	
	float fogFactor = 1.0 - (1.0 / exp(point.z * 0.0025));
    float diffuse = max(dot(normal, vec3(.9, .9, .9)), 0.0);
	
    color = mix(color * diffuse, vec3(1.), fogFactor);
	
	fragColor = vec4(color,1.0);
}