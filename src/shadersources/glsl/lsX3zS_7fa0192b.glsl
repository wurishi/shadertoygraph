// by srtuss, 2013
// messing around with voronoi noise
// requires more work though, but i'm too lazy atm ;)

// rotate position around axis
vec2 rotate(vec2 p, float a)
{
	return vec2(p.x * cos(a) - p.y * sin(a), p.x * sin(a) + p.y * cos(a));
}

// 1D random numbers
float rand(float n)
{
    return fract(tan(n) * 43758.5453123);
}

// 2D random numbers
vec2 rand2(in vec2 p)
{
	return fract(vec2(sin(p.x * 51.32 + p.y * 154.077), cos(p.x * 391.32 + p.y * 49.077)));
}

// 1D noise
float noise1(float p)
{
	float fl = floor(p);
	float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.0), fc);
}

// voronoi distance noise, based on iq's articles
vec2 voronoi(in vec2 x)
{
	vec2 p = floor(x);
	vec2 f = fract(x);
	
	vec2 res = vec2(8.0);
	for(int j = -1; j <= 1; j ++)
	{
		for(int i = -1; i <= 1; i ++)
		{
			vec2 b = vec2(i, j);
			vec2 r = vec2(b) - f + rand2(p + b);
			
			// chebyshev distance - one of many ways to do this
			float d = max(abs(r.x), abs(r.y));
			
			if(d < res.x)
			{
				res.y = res.x;
				res.x = d;
			}
			else if(d < res.y)
			{
				res.y = d;
			}
		}
	}
	return res;
}

float scene(vec3 p)
{
	vec2 ns = voronoi(p.yz);
	return 0.5 - abs(p.x) + (ns.y - ns.x) * 0.5 + (cos(p.x * 5.5) + tan(p.y * 1.5)) * 0.3;
}

vec3 normal(vec3 p)
{
	float v = scene(p);
	vec3 n;
	vec2 d = vec2(0.01, 0.0);
	n.x = v - scene(p + d.xyy);
	n.y = v - scene(p + d.yxy);
	n.z = v - scene(p * d.yyx);
	return normalize(n);
}

float intersect(inout vec3 ray, vec3 dir)
{
	float dist = 0.0;
	for(int i = 0; i < 10; i ++)
	{
		dist += scene(ray + dir * dist);
		if(dist > 5.0)
			return dist;
	}
	ray += dir * dist;
	return dist;
}

vec3 shade(vec3 ray, vec3 dir, vec3 nml, float dist)
{
	vec3 col = vec3(0.0, 1.0, 0.0);
	vec2 ns = voronoi(ray.yz);
	
	vec3 light = normalize(vec3(0.2, 1.0, 0.3));
	
	// lightig
	float diff = dot(nml, -light) * 0.4 + 0.6;
	vec3 ref = reflect(dir, nml);
	float spec = max(dot(ref, light), 0.0);
	spec = pow(spec, 8.0);
	
	// fake ambient occlusion
	float occ = exp(-(ns.y - ns.x));//exp(-abs(ray.x) * 1.5) * 2.0;
	col = vec3(0.0, 0.7, 1.0);
	//col += texture(iChannel0, ref).xyz * 0.3;
	col *= diff * 3.0;
	col += spec;
	col *= occ;
	
	// distance blackness
	col *= exp(-dist * 1.3);
	
	// simulate a torch or something
	col += exp(-dist * 0.999 - noise1(iTime * 20.0) + 0.5);
	
	return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = 2.0 * uv - 1.0;
	uv.x *= iResolution.x / iResolution.y;
	
	
	vec3 eye = vec3(0.0, 0.0, 2.0);
	float t = iTime / 20.5;
	//float fr = 0.0;
	//fr = sin(t) + sin(t * 2.0) * 0.5 + sin(t * 4.0) * 0.25;
	eye.y = -t * 0.1;// - fr * 0.2;
	
	vec3 ray = eye;
	
	vec3 col = vec3(0.0, 0.0, 0.0);
	
	vec3 dir = normalize(vec3(uv, 1.0));
	
	dir.yz = rotate(dir.yz, cos(iTime * 0.7) + 0.5 + 0.5);
	dir.xz = rotate(dir.xz, cos(iTime * 0.2) * 0.5);
	
	
	
	float dist = intersect(ray, dir);
	
	
	if(dist < 25.0)
	{
		vec3 nml, ref = dir;
		
		
		nml = normal(ray);
		col += 0.8 * shade(ray, ref, nml, dist);
		ref = reflect(ref, nml);
		ray += ref * 0.1;
		
		dist += intersect(ray, ref);
		if(dist < 35.0)
		{
			nml = normal(ray);
			col += 0.2 * shade(ray, ref, nml, dist);
		}
	}
	
	// more contrast
	col = pow(col, vec3(3.0));
	
	// gamma correction
	col = 1.0 - exp(-col * 4.0);
	
	fragColor = vec4(col, 1.0);
}