//http://www.matrix67.com/blog/archives/506


#define M_PI 3.141592653
#define M_EPSILON 0.005
#define K_MACRO_STEP 48
#define K_MICRO_STEP 16


mat3 AddRotateX(in mat3 m,in float angle)
{
	float cosa = cos(angle);
	float sina = sin(angle);
	mat3 mr = mat3(1.0,  0.0,  0.0,
				   0.0,  cosa, sina,
				   0.0,  -sina,cosa);
	return m * mr;
}
mat3 AddRotateY(in mat3 m,in float angle)
{
	float cosa = cos(angle);
	float sina = sin(angle);
	mat3 mr = mat3(cosa,  0.0, sina,
				   0.0,   1.0, 0.0,
				   -sina, 0.0, cosa);
	return m * mr;
}
mat3 AddRotateZ(in mat3 m, in float angle)
{
	float cosa = cos(angle);
	float sina = sin(angle);
	mat3 mr = mat3(cosa, sina, 0.0,
				   -sina,cosa, 0.0,
				   0.0,  0.0,  1.0);
	return m * mr;
}

mat3 Euler2Matrix(in vec3 euler)//y:heading, x:pitch, z:bank
{
	mat3 m = mat3(1.0,0.0,0.0,
		   0.0,1.0,0.0,
		   0.0,0.0,1.0);
	return AddRotateZ(AddRotateX(AddRotateY(m, euler.y), euler.x), euler.z);
}

vec2 DoRotate(in vec2 pos, in float angle)
{
	float cosa = cos(angle);
	float sina = sin(angle);
	return vec2(pos.x*cosa - pos.y*sina, pos.x*sina + pos.y*cosa);
}

struct STransform
{
	vec3 m_off;
	vec3 m_euler;
	float m_scale;
};

vec3 Transform(in vec3 xyz, in STransform trans)
{
	mat3 r = Euler2Matrix(trans.m_euler);
	return r * xyz * trans.m_scale + trans.m_off; 
}
vec3 InvTransform(in vec3 xyz, in STransform trans)
{
	vec3 re = xyz - trans.m_off;
	mat3 r = Euler2Matrix(-trans.m_euler);
	return r * re / trans.m_scale; 
}

struct Material
{
	vec4 m_diffuse;
	float m_specular_pow;
	float m_edge_pow;
};

float HitHeart(in vec3 p)
{
	float v1 = p.x*p.x + (9.0/4.0)*p.z*p.z + p.y*p.y-1.0;
	float re = v1*v1*v1 - 2.5*p.x*p.x * p.y*p.y*p.y - (9.0/80.0)*p.z*p.z*p.y*p.y*p.y;
	
	if( re < 0.0)
		return -re;
	return -1.0;
}

bool Hit(in vec3 p, in vec3 pre_p, inout vec3 hit_pos)
{
	for(int idx_x = -1; idx_x < 2; ++idx_x)
	{
	for (int idx_y = -1; idx_y < 2; ++idx_y)
	{
	//for (float idx_z = -1.5; idx_z < 1.5; idx_z += 1.0)
	//{
		float offx = float(idx_x)*0.7;
		float offy = float(idx_y)*0.7; 
		
		//float mod_timex = mod(iTime,M_PI*2.0);
		float mod_timey = mod(iTime,M_PI*2.0);
		
		//world inv trans
		STransform trans = STransform(vec3(offx, offy, 1.0), vec3(0.0, mod_timey, 0.0), 0.2*sin(iTime*4.0 + abs(offx + offy)) );
		vec3 pos1 = InvTransform(p, trans);
	
		float re1 = HitHeart(pos1);
		if (re1>=0.0)
		{
			vec3 pre_pos = InvTransform(pre_p, trans);
			vec3 pos2 = pre_pos;
			vec3 delta2 = (pos1-pre_pos) /float(K_MICRO_STEP);
		
			for (int ii=0; ii<K_MICRO_STEP; ++ii)
			{
				float re2 = HitHeart(pos2);
				if (re2 >= 0.0)
				{
					hit_pos = (pos2 * re1 - pos1 * re2)/(re1-re2);//exact value by linear estimate method......
					hit_pos = Transform(hit_pos, trans);
					return true;
				}
				
				pos2+=delta2;
			}
		}
	//}
	}
	}
	return false;
}

vec3 GetNormal(in vec3 hit_pos, in float delta)
{
	vec3 pre_p = hit_pos - vec3(0,0,delta);
	vec3 p = hit_pos + vec3(0,0,delta);
	
	vec3 t, l, r, b;
	t = l = r = b =  hit_pos + vec3(0.0,0.0, 10000.0);//hit very far away
	vec3 eps = vec3(M_EPSILON, 0.0, 0.0);
	t += eps.yxy;
	l -= eps.xyy;
	r += eps.xyy;
	b -= eps.yxy;
	
	Hit(p + eps.yxy , pre_p + eps.yxy, t);
	Hit(p -eps.xyy , pre_p -eps.xyy, l);
	Hit(p + eps.xyy , pre_p + eps.xyy, r);
	Hit(p -eps.yxy , pre_p -eps.yxy, b);

	return normalize(cross(r-l, t-b));
}

bool RayMarching(in vec2 screen_pos, in float near, in float far, out vec3 hit_pos, out float cal_delta)
{
	const float delta = 1.0/float(K_MACRO_STEP);
	
	float z_param1 = far-near;
	float z_param2 = near/z_param1;
	
	for (int i=0;i<K_MACRO_STEP; ++i)
	{
		vec3 pos = vec3(screen_pos, float(i)*delta);
		//ortho inv trans
		pos.z += z_param2;
		pos.z *= z_param1;
		
		//view inv trans
		//pass
		
		vec3 pre_pos = vec3(pos.xy, pos.z - delta * z_param1);
		
		vec3 re = pre_pos;
		if( Hit(pos, pre_pos, re))
		{
			hit_pos = re;
			cal_delta = delta*z_param1;
			return true;
		}
	}
	return false;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	//view port inv transform
	vec2 pos = (fragCoord.xy -iResolution.xy*0.5) / iResolution.xy * 2.0;
	
	vec3 hit_p = vec3(0.0,0.0,0.0);
	float delta = 1.0;
	bool re = RayMarching(pos, 0.0, 1.3, hit_p, delta);
	if (re)
	{
		vec3 nor = GetNormal(hit_p, delta);
		float mod_timey = mod(iTime*3.0,M_PI*2.0);
		vec3 light = vec3(sin(mod_timey),cos(mod_timey*4.0),0.2);
		float reflez= reflect(light - hit_p, nor).z;
		reflez = pow(reflez, 5.0)*0.7;
		fragColor = vec4(1.0-nor.y + reflez, 1.0-nor.z + reflez, 1.0-nor.x + reflez, 1.0);
	}
	else
	{
		fragColor = vec4(0.0,0.0,0.0,1.0);
	}
}