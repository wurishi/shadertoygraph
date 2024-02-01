//	Adopted from Noise - value noise / iq
//	https://www.shadertoy.com/view/lsf3WH

#define SCALE 1.

float hash(in vec2 p)
{
    return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453123);
}

float noise(in vec2 p)
{
    vec2 i = floor(p);
	vec2 f = fract(p); 
	f *= f*(3.0-2.0*f);
    
    vec2 c = vec2(0,1);
    
    return mix(mix(hash(i + c.xx), 
                   hash(i + c.yx), f.x),
               mix(hash(i + c.xy), 
                   hash(i + c.yy), f.x), f.y);
}

float fbm(in vec2 p)
{
	float f = 0.0;
	f += 0.50000 * noise(1.0 * p);
	f += 0.25000 * noise(2.0 * p);
	f += 0.12500 * noise(4.0 * p);
	f += 0.06250 * noise(8.0 * p);
	return f;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 ac = vec2(iResolution.x / iResolution.y , 1);
	vec2 uv = fragCoord.xy / iResolution.xy * ac * SCALE;
	float m = iMouse.x / iResolution.x * ac.x * SCALE;
			
	vec2 p = 5.0 * uv;
	
	float f = uv.x > m ? fbm(p) : noise(p);
	 
	fragColor = vec4(vec3(f * smoothstep(0., .01, abs(m - uv.x))), 1);
}