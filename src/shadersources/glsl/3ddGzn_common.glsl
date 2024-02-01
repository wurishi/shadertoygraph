

// Scene control:
//
// $0003	BA	1..0	- camera distance 0..3
// $000C	DC	3..2	- scenery 	00:forest		01:city
//									10:terrain		11:landscape
//	 								-0:circle		-1:triangle
//
// $0010	 E	 4		- 0:glowing		1:solid
// $0020	 F	 5		- large voronoi range / end phase of city destruction
// $0040	 G	 6		- city destruction
// $0080	 H	 7		- black sphere (only flag H = black screen)
// $0100	 I	 8		- camera angle
// $0200	 J	 9		- voronoi destruction
// $0400	 K	10		- camera distance + 0.5
// $0800	 L  11		- water (with C=0 D=1)
// $1000	 M  12		- darkness
// $2000	 N	13		- sharp OUT transition
// $4000	 O	14		- sharp IN transition
// $8000	 P	15		- shape particles
//
//


const ivec3 SCENES[] = ivec3[](
#define SCENE(n,d,b)	ivec3((d),(b),(n))

	//intro
	SCENE(2, 16, 0x050A | 0x0000),
	SCENE(3, 16, 0x040B | 0x0000),

	//PART 1 - forest+rocks
	SCENE(4, 12, 0x0013 | 0x4000),
	SCENE(5, 11, 0x0051 | 0x2000),
	SCENE(6, 1, 0x0410 | 0x6000),
	SCENE(7, 8, 0x0010 | 0x6000),
	SCENE(8, 12, 0x0110 | 0x4000),
	SCENE(9, 12, 0x001F | 0x0000),
	SCENE(10, 12, 0x001C | 0x6000),

	//the ball!
	SCENE(11, 8, 0x0080 | 0x0000), //d
	SCENE(13, 20, 0x0418 | 0x2000),

	//PART 2 - city
	SCENE(14, 16, 0x0407 | 0x4000),
	SCENE(15, 16, 0x0014 | 0x0000),
	SCENE(16, 20, 0x0124 | 0x6000),
	SCENE(17, 11, 0x0044 | 0x6000),

	//the ball!
	SCENE(18, 13, 0x0080 | 0x0000), //d        
	SCENE(20, 20, 0x0818 | 0x4000),

	//PART 3 - destruction
	SCENE(80, 16, 0x0041 | 0x2000),
	SCENE(21, 16, 0x0200 | 0x6000),
	SCENE(33, 16, 0x0074 | 0x0000),
	SCENE(22, 16, 0x040c | 0x7000),
	SCENE(24, 19, 0x063c | 0x3000),

	SCENE(26, 7, 0x0080 | 0x0000), //d

								   //outtro - water
	SCENE(28, 12, 0x1908 | 0x0000),
	SCENE(27, 16, 0x0808 | 0x1000),
	SCENE(97, 10, 0x0C08 | 0xB000),

	SCENE(96, 8, 0x0080 | 0x0000), //d

								   //the ball! 
//	SCENE(30, 12, 0x0018 | 0x4000),
//	SCENE(31, 16, 0x0098 | 0x0000),
	SCENE(32, 24, 0x0098 | 0x6000),
	SCENE(0, 255, 0x0080 | 0x0000) //d	
#undef SCENE
	);



// ================================ Helper functions ================================


float sat(float x)
{
	return clamp(x, 0., 1.);
}


// ================================ Noises ================================

// 3D noise - method by iq/shane
float noise(vec3 p)
{
	vec3 ip=floor(p);
	p-=ip;
	vec3 s=vec3(7, 157, 113);
	vec4 h=vec4(0, s.yz, s.y+s.z)+dot(ip, s);
	p=p*p*(3.-2.*p);
	h=mix(fract(43758.5*sin(h)), fract(43758.5*sin(h+s.x)), p.x);
	h.xy=mix(h.xz, h.yw, p.y);
	return mix(h.x, h.y, p.z);
}


// ================================ Voronoi ================================

vec2 vcore(vec2 m, vec2 p, vec2 s)
{
	vec2 c = floor(2.5*p+s);		// 1./.4   r
	c += fract(43758.5*sin(c+17.*c.yx));

	float v = length(.4*c-p);	// r
	return v<m.x ? vec2(v, m.x) : v<m.y ? vec2(m.x, v) : m;
}



// ================================ Patterns ================================


float lattice(vec3 p)
{
	p=abs(p);
	p=max(p, p.yzx);
	p=min(p, p.yzx);
	p=min(p, p.yzx);
	return p.x;
}



// ================================ SDF merge functions ================================


void dmin(inout vec3 d, float x, float y, float z)
{
	if( x < d.x ) d = vec3(x, y, z);
}



// ================================ Domain operations ================================


// rotation
void pR(inout vec2 p, float a)
{
	a *= 6.283;
	p = cos(a)*p+sin(a)*vec2(p.y, -p.x);
}


// 3D repetition
vec3 rep(vec3 p, float r)
{
	return (fract(p/r-.5)-.5)*r;
}

// diffuse reflection hash - method by fizzer
vec3 hashHs(vec3 n, inout float seed)
{
	vec2 uv = (seed=32.+seed*fract(seed))+vec2(78.233, 10.873);
	uv = fract(.1031*uv);
	uv *= 19.19+uv;
	uv = fract(2.*uv*uv);

	float u = 2.*uv.x-1.;

	vec3 v = vec3(sqrt(1.-u*u), 0., u);
	pR(v.xy, uv.y);
	return normalize(n+v);
}


// ================================ Complex SDFs ================================

float vines(vec3 p, float s)
{
	p.y=abs(p.y);
	pR(p.xz, .1*p.y); p=abs(p); p.xz -= .06*s;
	pR(p.xz, -.16*p.y); p=abs(p); p.xz -= .05*s;
	pR(p.xz, .4*p.y);
	return length(abs(p.xz) - .04*(s*.5+.5));
}
