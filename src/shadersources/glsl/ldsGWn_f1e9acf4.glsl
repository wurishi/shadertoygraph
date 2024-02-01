#define M_PI	3.141593
#define FOV		(M_PI / 4.0)
#define DEG(x)	(M_PI * (x) / 180.0)
#define DIST_THRES 0.001

struct Ray {
	vec3 origin;
	vec3 dir;
};

float calc_dist(in vec3 pos);
vec3 calc_normal(vec3 pt);
vec3 shade(in vec3 pos, in vec3 norm);
vec3 backdrop(in Ray ray);
Ray get_primary_ray(float theta, float phi, float dist, in vec2 fragCoord);
vec3 vec_rotx(in vec3 v, float a);
vec3 vec_roty(in vec3 v, float a);
vec3 vec_rotz(in vec3 v, float a);
float anim_angle(in float degps);
vec3 srgb_to_linear(in vec3 srgb_color);
vec3 linear_to_srgb(in vec3 lin_color);


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 color;
	Ray ray = get_primary_ray(anim_angle(8.0), DEG(20.0), 6.0, fragCoord);
	ray.origin.y += 1.0;
	
	float dist = 100.0;
	float t = 0.0;
	for(int i=0; i<128; i++) {
		if(dist < DIST_THRES || t > 16.0) {
			break;
		}
		dist = calc_dist(ray.origin);
		
		float dt = max(dist, DIST_THRES);
		ray.origin = ray.origin + ray.dir * dt;
		t += dt;
	}


	if(dist < DIST_THRES) {
		color = shade(ray.origin, calc_normal(ray.origin));
	} else {
		color = backdrop(ray);
	}


	fragColor.xyz = linear_to_srgb(color);
	fragColor.w = 1.0;
}

float sphere(in vec3 pos, in vec3 center, float rad)
{
	return dot(pos - center, pos - center) - rad;
}

float calc_dist(in vec3 pos)
{
	float res = sphere(pos, vec3(0.0, 1.0, 0.0), 1.0);
	res = min(res, pos.y);
	return res;
}

vec3 texturef(in vec3 pos)
{
	if(pos.y <= 0.01) {
		vec2 foo = floor(mod(pos.xz, 2.0));
		float chess = abs(foo.x - foo.y);
		return vec3(chess, 0.4, 1.0 - chess);
	}
	return vec3(1.0, 0.3, 0.1);
}

vec3 shade(in vec3 pos, in vec3 norm)
{
	vec3 diffuse = vec3(0.0, 0.0, 0.0);
	vec3 specular = vec3(0.0, 0.0, 0.0);

	vec3 ldir = normalize(vec3(-1.0, 1.0, -1.0));
	diffuse = max(dot(ldir, norm), 0.0) * texturef(pos);

	return diffuse + specular;
}

vec3 backdrop(in Ray ray)
{
	vec3 dir = ray.dir;
	
	return srgb_to_linear(texture(iChannel0, dir).xyz);
}

#define OFFS 1e-4
vec3 calc_grad(vec3 pt)
{
	vec3 grad;
	grad.x = calc_dist(pt + vec3(OFFS, 0.0, 0.0)) - calc_dist(pt - vec3(OFFS, 0.0, 0.0));
	grad.y = calc_dist(pt + vec3(0.0, OFFS, 0.0)) - calc_dist(pt - vec3(0.0, OFFS, 0.0));
	grad.z = calc_dist(pt + vec3(0.0, 0.0, OFFS)) - calc_dist(pt - vec3(0.0, 0.0, OFFS));
	return grad;
}

vec3 calc_normal(vec3 pt)
{
	return normalize(calc_grad(pt));
}

vec2 calc_sample_pos(in vec2 fragCoord)
{
	float aspect = iResolution.x / iResolution.y;
	vec2 p = vec2(2.0, 2.0) * fragCoord.xy / iResolution.xy - vec2(1.0, 1.0);
	
	return p * vec2(aspect, 1.0);
}

Ray get_primary_ray(float theta, float phi, float dist, in vec2 fragCoord)
{
	Ray ray;
	
	ray.origin = vec3(0.0, 0.0, 0.0);
	ray.dir = vec3(calc_sample_pos(fragCoord), 1.0 / tan(FOV / 2.0));
	
	// place the camera in the specified spherical coordinates looking in...
	ray.origin.x = sin(theta) * cos(phi) * dist;
	ray.origin.y = sin(phi) * dist;
	ray.origin.z = cos(theta) * cos(phi) * dist;

	ray.dir = vec_rotx(ray.dir, -phi);
	ray.dir = vec_roty(ray.dir, -theta + M_PI);

	ray.dir = normalize(ray.dir);
	return ray;
}

vec3 vec_rotx(in vec3 v, float a)
{
	vec3 row1 = vec3(0.0, cos(a), sin(a));
	vec3 row2 = vec3(0.0, -sin(a), cos(a));
	return vec3(v.x, dot(row1, v), dot(row2, v));
}

vec3 vec_roty(in vec3 v, float a)
{
	vec3 row0 = vec3(cos(a), 0.0, -sin(a));
	vec3 row2 = vec3(sin(a), 0.0, cos(a));
	return vec3(dot(row0, v), v.y, dot(row2, v));
}

vec3 vec_rotz(in vec3 v, float a)
{
	vec3 row0 = vec3(cos(a), sin(a), 0.0);
	vec3 row1 = vec3(-sin(a), cos(a), 0.0);
	return vec3(dot(row0, v), dot(row1, v), v.z);
}

float anim_angle(in float degps)
{
	return mod(DEG(iTime * degps), 2.0 * M_PI);
}


vec3 srgb_to_linear(in vec3 srgb_color)
{
	return pow(srgb_color, vec3(2.2));
}

vec3 linear_to_srgb(in vec3 lin_color)
{
	return pow(lin_color, vec3(1.0 / 2.2));
}