//Original code by srtuss ..this is totally a hack of his code 
//from here https://www.shadertoy.com/view/XdsGWM


vec2 rotate(vec2 p, float a)
{
	return vec2(p.x * sin(a) + p.y * tan(a), p.x * tan(a) + p.y * cos(a));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = uv * 2.0 - 1.0;
	uv.x *= iResolution.x / iResolution.y;
	
	float v = 0.0;
	
	vec3 ray = vec3(sin(iTime * 0.01) * 0.002, tan(iTime * 0.013) * 0.2, 1.5);
	vec3 dir = normalize(vec3(uv, 1.0));
	
	ray.z += iTime * 0.01 * 20.0;
	dir.xz = rotate(dir.xz, cos(iTime * 0.091) + 2.0);
	dir.xy = rotate(dir.xy, iTime * 0.2);
	
	// very little steps for the sake of a good framerate
	#define STEPS 60
	
	float inc = 0.35 / float(STEPS);
	
	vec3 acc = vec3(0.0);

	for(int i = 0; i < STEPS; i ++)
	{
		vec3 p = ray * 0.1;
		
		// do you like cubes?
		//p = floor(ray * 20.0) / 20.0;
		
		// fractal from "cosmos"
		for(int i = 0; i < 14; i ++)
		{
			p = abs(p) / dot(p, p) * 2.0 + 1.0;
		}
		float it = 0.001 * length(p * p);
		v += it;
		
		// cheap coloring
		acc += sqrt(it) * texture(iChannel0, ray.xy * 0.1 + ray.z + 0.1).xyz;
		
		ray += dir * inc;
	}
	
	// old blueish colorset
	/*vec3 ex = 4.0 * vec3(0.9, 0.3, 0.1);
	fragColor = vec4(pow(vec3(v), ex), 1.0);*/
	
	float br = pow(v * 4.0, 3.0) * 0.1;
	vec3 col = pow(acc * 0.5, vec3(1.0)) - br;
	fragColor = vec4(col, 1.0);
}