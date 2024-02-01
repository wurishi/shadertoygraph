// by nikos papadopoulos, 4rknova / 2013
// Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

//#define USE_MOUSE

#define EPSILON				0.0005
#define EPSILON_M			0.01
#define PI					3.14159265359
#define PI2					PI * 0.5
#define RADIAN				180.0 / PI

#define RMARCH_MAX_STEPS 	128
#define SMARCH_MAX_STEPS	64

#define PENUMBRA_K			20.0

const float cCamera_fov = 60.0;

struct Camera	{ vec3 p, t, u; };
struct Ray		{ vec3 o, d; };
struct Light	{ vec3 p, d, s; };
struct Material { vec3 d, s; float e; };

Camera c;
Light  l;

vec3  translate	(vec3 v, vec3 t)	 { return v - t; }
float opu		(float d1, float d2) { return min( d1, d2); }
float ops		(float d1, float d2) { return max( d1,-d2); }
float opi		(float d1, float d2) { return max( d1, d2); }

float ds_sphere	(vec3 p, float r)			{ return length(p) - r; }
float ds_plane	(vec3 p, vec4 n)			{ return dot(p,normalize(n.xyz)) + n.w; }				 
float du_boxr	(vec3 p, vec3 b, float r)	{ return length(max(abs(p)-b,0.0)) - r; }
float du_floor	(vec3 p, vec3 c, vec3 b, float r)
{
	vec3 q = mod(p, c) - 0.5 * c;
	q.y = p.y;
	return du_boxr(q,b,r);
}

float du_base (vec3 p)
{
	float d = du_boxr(translate(p,vec3(-4.0,0.0,5.0)), vec3(0.5, 10.0, 2.5), 0.0);
		  d = opu(d, du_boxr(translate(p,vec3(4.0,0.0,5.0)), vec3(0.5, 10.0, 2.5), 0.0));
		  d = opu(d, du_boxr(translate(p,vec3(0.0,0.0,5.0)), vec3(10.5, 4.5, 1.5), 0.0));
		  d = ops(d, du_boxr(translate(p,vec3(0.0,9.5,4.5)), vec3(5.5, 0.8, 0.5), 0.6));
		  d = ops(d, ds_sphere(translate(p,vec3(-9.0,5.0,5.0)), 4.0));
		  d = ops(d, ds_sphere(translate(p,vec3( 9.0,5.0,5.0)), 4.0));
		  d = opu(d, du_boxr(translate(p,vec3(0.0,0.0,5.5)), vec3(3.4, 2.5, 2.5), 0.0));
		  
	return d;	
}

float du_sword(vec3 p)
{
	float d = ds_sphere(translate(p,vec3(7.0,9.0,5.0)), 2.5);
	
		  d = opi(d, du_boxr(translate(p,vec3(7.0,9.0,5.0)), vec3(0.1, 3.0, 3.0), 0.0));

		  d = opu(d, du_boxr(translate(p,vec3(-4.0,9.0,5.0)), vec3(10.5, 0.05, 0.1), 1.0));
		  d = opu(d, du_boxr(translate(p,vec3(11.0,9.0,5.0)), vec3(3.5, 0.1, 0.1), 1.0));
		 
	return d;
}
	
void generate_ray(Camera c, in vec2 fragCoord, out Ray r)
{
	float ratio = iResolution.x / iResolution.y;

	vec2  uv = (2.0 * fragCoord.xy / iResolution.xy - 1.0)
			 * vec2(ratio, 1.0);
	
	r.o = c.p;
	r.d = normalize(vec3(uv.x, uv.y, 1.0 / tan(cCamera_fov * 0.5 * RADIAN)));
	
	vec3 cd = c.t - c.p;

	vec3 rx,ry,rz;
	rz = normalize(cd);
	rx = normalize(cross(rz, c.u));
	ry = normalize(cross(rx, rz));
	
	mat3 tmat = mat3(rx.x, rx.y, rx.z,
			  		 ry.x, ry.y, ry.z,
					 rz.x, rz.y, rz.z);

	
	r.d = normalize(tmat * r.d);
}

/********************************************************************************/
// Scene
/********************************************************************************/

// Returns the distance from the scene geometry
float scene_distance(vec3 p)
{
	float d = du_floor(translate(p, vec3(0.0, -1.19,0.0)), vec3(2.0),vec3(0.7), 0.4);
	d = opu(d, du_base(p));
	d = opu(d, du_sword(p));
	
	return d;
}


vec3 scene_normal(vec3 p, float d)
{
    vec3 n;
	
	// Gradient via Forward differencing
    n.x = scene_distance(vec3(p.x + EPSILON, p.y, p.z));
    n.y = scene_distance(vec3(p.x, p.y + EPSILON, p.z));
    n.z = scene_distance(vec3(p.x, p.y, p.z + EPSILON));
	
    return normalize(n - d);
}

vec3 scene_shade(vec3 p, vec3 n, Light l, Material m, Camera c)
{
	return l.d * m.d * dot(n, normalize(l.p - p))
		 + l.s * m.s * pow(clamp(dot(normalize(reflect(l.p - p, n)), normalize(p - c.p)), 0.0, 1.0), m.e);
}

vec3 scene_color(vec3 p)
{
	vec3 col = vec3(0.6);
	
	if (p.y > 0.0)
	{
		col = vec3(0.8,0.6,0.4);
		
		if (p.y > 5.0) {
			if (p.x > 6.88 && p.x < 7.2)
				col = vec3(0.5);
			else if(p.x > 7.2)
				col = vec3(0.3,0.4,0.5);
			else if (p.y > 8.0 && p.z > 3.8 && p.z < 5.7)
				col = vec3(0.6,0.0,0.0);
		}
	}

	return col;
}

/********************************************************************************/
// Ray Marching
/********************************************************************************/

// Returns if there was an intersection.
bool raymarch(Ray r, out vec3 p, out vec3 n)
{
	p = r.o;
	vec3 pos = p;
	float d = 1.;

	for (int i = 0; i < RMARCH_MAX_STEPS; i++)
	{
		d = scene_distance(pos); // Get the distance.

		if (d < EPSILON)
		{
			p = pos;
			break;
		}
		
		pos += d * r.d;
	}
	
	n = scene_normal(p, d);
	return d < EPSILON;
}


float shadow( in vec3 ro, in vec3 rd)
{
	float res = 1.0;
	
	float t = EPSILON_M;
	
	for (int i = 0; i < SMARCH_MAX_STEPS; i++) {
        float d = scene_distance(ro + rd * t);
		
		if (d < EPSILON) {
			return 0.0;
			break;
		}
		
        res = min(res, PENUMBRA_K * d / t);

        t += d;
    }

    return res;
}

/********************************************************************************/
// Main
/********************************************************************************/

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{	
 
	c.p =
#ifdef USE_MOUSE
		vec3(iMouse.x / iResolution.x * 20.0 - 10.0,
			 1.0 + 30.0 * iMouse.y / iResolution.y, -15.0);
		//c.p.z = c.p.x + c.p.y;
#else
		vec3(-10.0, 25.0, -15.0);
#endif
		
	c.t = vec3(0.0, 5.0, 0.0);
	c.u = normalize(vec3(0.1, 1.0, 0.0));
	
	Ray r;
	generate_ray(c, fragCoord, r);
				 
	vec3 sp, sn;
	
	vec3 col = vec3(0.0);

	if (raymarch(r, sp, sn))
	{
		l.p = vec3(15.0 * cos(iTime), 14.0, -5.0 +  5.0 * sin(iTime));
		l.d = vec3(1.0);
		l.s = vec3(1.0);
		
		Material m;
		m.d = scene_color(sp);
		m.s = 1.0 - m.d;
		m.e = 128.0;
	
		col = shadow(sp, normalize(l.p - sp)) * scene_shade(sp, sn, l, m, c);
	}
	
	// Fade in	
	col *= smoothstep(EPSILON, 3.5, iTime);
	
	fragColor = vec4(col, 1.0);
}