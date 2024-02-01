struct ray
{
	vec3 pos;
	vec3 dir;
	int mat_id;
};
	
struct surface
{
	vec3 pos;
	vec3 n;
	
	vec4 ambi;
	vec4 diff;
	vec4 spec;
	float shiny;
	
	vec4 refl;
};

struct light
{
	vec3 pos;
	vec3 dir;
	vec3 att;
	
	vec4 diff;
	vec4 spec;
};

	
///////////
// Variables
//////////
	

const int march_iter = 45;
const float march_dist = 0.007;
const float march_bias = 0.99;

const int max_reflects = 2;

const int num_lights = 2;
const float ao_bias = 0.2;
const float n_eps = 0.01;
const float shadow_eps = 0.01;
	
///////////
// Material and light properties
///////////

void getlight (in int i, out light l)
{
    vec2 mouse = (iMouse.xy/iResolution.xy-vec2(0.5,0.5))*vec2(iResolution.x/iResolution.y,1);

	if (i == 0)
	{
		l.pos = vec3 (mouse,0.5);
		l.dir = vec3(0.1,0,-1);
		l.att = vec3(0.1,1,1);
		
		const vec4 color = vec4 (0.4,0.0,0.0,1.0);
		l.diff = 0.7*color;
		l.spec = 0.3*color;
		
	}
	else if (i == 1)
	{
		l.pos = vec3 (0.5,0.1,-1);
		l.dir = vec3(0.1,0,-1);
		l.att = vec3(0.1,1,1);
		
		vec4 color = vec4(0.0,0.2*sin(iTime)+0.2,0.2*cos(iTime)+0.2,1.0);
		l.diff = 0.5*color;
		l.spec = 0.3*color;
	}
	else
	{
		//blank light
	}
}

///////////
// Scene
///////////


// Copy-pasta'd
vec2 scene (in vec3 pos)
{
	vec3 z = pos;
	float dr = 1.0;
	float r = 0.0;
	for (int i = 0; i < 10 ; i++) {
		r = length(z);
		if (r>2.0) break;
		
		// convert to polar coordinates
		float theta = acos(z.z/r);
		float phi = atan(z.y,z.x);
		float Power = smoothstep(0.0, 1.0, iTime/20.0)*6.0+2.0;
		
		dr =  pow( r, Power-1.0)*Power*dr + 1.0;
		// scale and rotate the point
		float zr = pow( r,Power);
		theta = theta*Power;
		phi = phi*Power;
		
		// convert back to cartesian coordinates
		z = zr*vec3(sin(theta)*cos(phi), sin(phi)*sin(theta), cos(theta));
		z+=pos;
	}
	return vec2(0.5*log(r)*r/dr,0);
}

///////////

vec3 toViewDir (in vec3 pos)
{
	float r = iTime/10.0;
	pos.xz = vec2(cos(r)*pos.x-sin(r)*pos.z, sin(r)*pos.x+cos(r)*pos.z);
	return pos;
}

vec3 toView (in vec3 pos)
{
	float r = iTime/10.0;
	pos+=vec3(0,0,-2.5);
	pos.xz = vec2(cos(r)*pos.x-sin(r)*pos.z, sin(r)*pos.x+cos(r)*pos.z);
	return pos;
}

vec4 background (in ray r)
{
	return texture(iChannel0,toViewDir(r.dir));
}

///////////
// Raymarching
///////////

vec2 dE (in vec3 pos)
{
	return scene(toView(pos));
}

bool raymarch (inout ray r)
{
	float dist = 0.0;
	bool hit = false;
	for(int i=0; i<march_iter; i++)
	{
		vec2 res = dE(r.pos+r.dir*dist);
		dist += res.x;
		if (res.x<=march_dist)
		{
			r.pos += r.dir*dist*pow(march_bias,1.0+1.0/dist);
			r.mat_id = int(res.y);
			hit = true;
			break;
		}
	}
	return hit;
}

void rayreflect (surface s, inout ray r)
{
	r.dir = reflect(r.dir,s.n);
}

///////////
// Lighting
///////////

bool inshadow(in surface s, in light l)
{
	ray r;
	r.pos = s.pos;
	
	r.dir = l.pos-s.pos;
	float dist = length(r.dir);
	r.dir = normalize(r.dir);

	return raymarch(r) && length(r.pos-s.pos)<dist;
}

float getao (in surface s)
{
	return clamp(dE(s.pos+s.n*ao_bias).x/ao_bias, 0.0, 1.0);
}

vec4 blinnphong (in surface s, in light l)
{
	vec3 s2v = normalize(-s.pos);
	vec3 s2l = l.pos-s.pos;
	float d = length(s2l);
	s2l = normalize(s2l);
	
	vec4 diff = s.diff*l.diff
		*max(0.0,dot(s2l,s.n));
	vec4 spec = s.spec*l.spec*
		pow(max(0.0,dot(s2v,-reflect(s2l,s.n))),s.shiny);
	
	float att = dot(vec3(d*d,d,1.0),l.att);
	float falloff = max(0.0,dot(s2l,l.dir));
	
	return (diff+spec)*falloff/att;
}

vec4 blinnphong (in surface s)
{
	vec4 total = s.ambi*getao(s);
	for (int i=0; i<num_lights; i++)
	{
		light l;
		getlight(i,l);
		if(!inshadow(s,l))
		{
			total+=blinnphong(s,l);
		}
	}
	return total;
}

vec3 getnormal (in vec3 pos)
{
	vec2 e = vec2 (n_eps, 0);
	return normalize(vec3(
		dE(pos+e.xyy).x-dE(pos-e.xyy).x,
		dE(pos+e.yxy).x-dE(pos-e.yxy).x,
		dE(pos+e.yyx).x-dE(pos-e.yyx).x));
	//return normalize
	//	( dE(pos+e.xyy).x * e.xyy
	//	+ dE(pos+e.yxy).x * e.yxy
	//	+ dE(pos+e.yyx).x * e.yyx
	//	+ dE(pos+e.xxx).x * e.xxx);
}

void getsurface (in ray r, out surface s)
{
	s.pos = r.pos;
	s.n = getnormal(r.pos);
	const vec4 color = vec4(1,1,1,1);
		s.ambi = 0.2*color;
		s.diff = color;
		s.spec = color;
		s.shiny = 10.0;
		
		s.refl = 0.2*color;
}

vec4 render(in ray r)
{
	vec4 refl = vec4(1,1,1,1);
	vec4 total = vec4(0,0,0,0);
	
	for(int i=0; i<=max_reflects; i++)
	{
		bool hit = raymarch(r);
		
		if(hit)
		{
			surface s;
			getsurface(r, s);
			total += refl*blinnphong(s);
			refl *= s.refl;
			rayreflect(s, r);
		}
		else
		{
			total += refl*background(r);
			break;
		}
	}
	return total;
}

vec3 getDir (vec2 fragCoord)
{
	vec2 loc = fragCoord.xy/iResolution.xy - vec2(0.5,0.5);
	loc.x *= iResolution.x/iResolution.y;
	float dist = 1.0;
	return vec3(loc,dist);	
}

vec4 render(vec2 fragCoord)
{
	ray r;
	r.pos = vec3(0,0,0);
	r.dir = getDir(fragCoord);
	return render(r);	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	fragColor = render(fragCoord);
}