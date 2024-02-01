// Copyright (c) Timo Saarinen 2021
// You can use this Work in a Good and Cool Spirit.
//
// Disclaimer: WIP!
//------------------------------------------------------------------------
const int NUM_SAMPLES = 1;
const float EXPOSURE = 30.0;
    
const float PI = 3.141592; // close enough
const float TWO_PI = 2.*PI;
const float EPSILON = 0.0001;
const float NOHIT = 999999999.0; // keep positive intersection miss, so can easily min() the closest one
const float FADE_DIST = 500.;

const int ID_NONE       = 0;
const int ID_SPHERE01   = 1;
const int ID_SPHERE02   = 2;
const int ID_SPHERE03   = 3;
const int ID_PLANE      = 4;
const int ID_CARROTCONE = 5;

const vec3 sun_dir = normalize(vec3(1,1,1));
const float camera_alt = 1.9;
const float camera_distance = 2.5;
const vec3 camera_look_at_tree = vec3(0,3,0);
const float sphere_radius[3] = float[3](0.3, 0.25, 0.15); // legs, torso, head
const float sphere_alt[3]    = float[3](-0.1 + 0.3, -0.1 + 1.5*0.3 + 0.25, -0.1 + 1.5*0.3 + 1.8*0.25 + 0.15);
const float sphere_dist = 1.9;
const float jump_altitude = 0.5;
const vec3 planen = vec3(0,1,0);
const float plane_alt = 1.6;
const float plane_radius = 500.0; // floor circle

//------------------------------------------------------------------------
vec3 HDR_to_LDR(vec3 c) { return pow(c, vec3(1.0/2.2)); }
vec3 LDR_to_HDR(vec3 c) { return pow(c, vec3(2.2)); }

//------------------------------------------------------------------------
// taken from iq :)
float seed;	//seed initialized in main
float rnd() { return fract(sin(seed++)*43758.5453123); } // [0,1]
float rnd_signed() { return 2.*rnd() - 1.; } // [-1,1]

float noise(vec3 p)
{
	vec3 ip=floor(p);
    p-=ip; 
    vec3 s=vec3(7,157,113);
    vec4 h=vec4(0.,s.yz,s.y+s.z)+dot(ip,s);
    p=p*p*(3.-2.*p); 
    h=mix(fract(sin(h)*43758.5),fract(sin(h+s.x)*43758.5),p.x);
    h.xy=mix(h.xz,h.yw,p.y);
    return mix(h.x,h.y,p.z); 
}

float dot2( in vec3 v ) { return dot(v,v); }

vec4 iCappedCone( in vec3  ro, in vec3  rd, 
                  in vec3  pa, in vec3  pb, 
                  in float ra, in float rb )
{
    vec3  ba = pb - pa;
    vec3  oa = ro - pa;
    vec3  ob = ro - pb;
    
    float m0 = dot(ba,ba);
    float m1 = dot(oa,ba);
    float m2 = dot(ob,ba); 
    float m3 = dot(rd,ba);

    //caps
         if( m1<0.0 ) { if( dot2(oa*m3-rd*m1)<(ra*ra*m3*m3) ) return vec4(-m1/m3,-ba*inversesqrt(m0)); }
    else if( m2>0.0 ) { if( dot2(ob*m3-rd*m2)<(rb*rb*m3*m3) ) return vec4(-m2/m3, ba*inversesqrt(m0)); }
    
    // body
    float m4 = dot(rd,oa);
    float m5 = dot(oa,oa);
    float rr = ra - rb;
    float hy = m0 + rr*rr;
    
    float k2 = m0*m0    - m3*m3*hy;
    float k1 = m0*m0*m4 - m1*m3*hy + m0*ra*(rr*m3*1.0        );
    float k0 = m0*m0*m5 - m1*m1*hy + m0*ra*(rr*m1*2.0 - m0*ra);
    
    float h = k1*k1 - k2*k0;
    if( h<0.0 ) return vec4(-1.0);

    float t = (-k1-sqrt(h))/k2;

    float y = m1 + t*m3;
    if( y>0.0 && y<m0 ) 
    {
        return vec4(t, normalize(m0*(m0*(oa+t*rd)+rr*ba*ra)-ba*hy*y));
    }
    
    return vec4(NOHIT); //vec4(-1.0);
}

//------------------------------------------------------------------------
vec3 random_hemisphere_dir(in vec3 n) {
    vec3 dir;
    dir.x = rnd_signed();
    dir.y = rnd_signed();
    dir.z = rnd_signed();
    dir = normalize(dir);
    return dot(dir,n) > 0. ? dir : -dir;
}

// https://www.shadertoy.com/view/MsXfz4
// https://www.shadertoy.com/view/4sSSW3
void basis(in vec3 n, out vec3 f, out vec3 r) {
    if(n.z < -0.999999) {
        f = vec3(0 , -1, 0);
        r = vec3(-1, 0, 0);
    } else {
    	float a = 1./(1. + n.z);
    	float b = -n.x*n.y*a;
    	f = vec3(1. - n.x*n.x*a, b, -n.x);
    	r = vec3(b, 1. - n.y*n.y*a , -n.y);
    }
}
mat3 mat3FromNormal(in vec3 n) {
    vec3 x;
    vec3 y;
    basis(n, x, y);
    return mat3(x,y,n);
}
vec3 l2w( in vec3 localDir, in vec3 normal ) {
    vec3 a,b;
    basis( normal, a, b );
	return localDir.x*a + localDir.y*b + localDir.z*normal;
}
void cartesianToSpherical( 	in vec3 xyz,
                         	out float rho,
                          	out float phi,
                          	out float theta ) {
    rho = sqrt((xyz.x * xyz.x) + (xyz.y * xyz.y) + (xyz.z * xyz.z));
    phi = asin(xyz.y / rho);
	theta = atan( xyz.z, xyz.x );
}
vec3 sphericalToCartesian( in float rho, in float phi, in float theta ) {
    float sinTheta = sin(theta);
    return vec3( sinTheta*cos(phi), sinTheta*sin(phi), cos(theta) )*rho;
}
vec3 sampleHemisphereCosWeighted(in vec2 xi) {
    float theta = acos(sqrt(1.0-xi.x));
    float phi = TWO_PI * xi.y;
    return sphericalToCartesian( 1.0, phi, theta );
}
vec3 sampleHemisphereCosWeighted( in vec3 n, in vec2 xi ) {
    return l2w( sampleHemisphereCosWeighted( xi ), n );
}
vec3 randomDirection( in float Xi1, in float Xi2 ) {
    float theta = acos(1.0 - 2.0*Xi1);
    float phi = TWO_PI * Xi2;
    
    return sphericalToCartesian( 1.0, phi, theta );
}

//------------------------------------------------------------------------
// Star background
// https://www.shadertoy.com/view/XsyGWV
vec3 nmzHash33(vec3 q)
{
    uvec3 p = uvec3(ivec3(q));
    p = p*uvec3(374761393U, 1103515245U, 668265263U) + p.zxy + p.yzx;
    p = p.yzx*(p.zxy^(p >> 3U));
    return vec3(p^(p >> 16U))*(1.0/vec3(0xffffffffU));
}
vec3 stars(in vec3 p)
{
    vec3 c = vec3(0.);
    float res = iResolution.x*0.8;
    
	for (float i=0.;i<3.;i++)
    {
        vec3 q = fract(p*(.15*res))-0.5;
        vec3 id = floor(p*(.15*res));
        vec2 rn = nmzHash33(id).xy;
        float c2 = 1.-smoothstep(0.,.6,length(q));
        c2 *= step(rn.x,.0005+i*i*0.001);
        c += c2*(mix(vec3(1.0,0.49,0.1),vec3(0.75,0.9,1.),rn.y)*0.25+0.75);
        p *= 1.4;
    }
    return c*c*.7;
}
//------------------------------------------------------------------------
vec3 fog(vec3 dir, vec3 c) {
    float t = 1.0 - clamp(abs(dir.y) / 0.05, 0.0, 1.0);
    t *= t;
    return mix(c, vec3(0.0015), t);
}

vec3 background_ldr(vec3 dir) { // specular
    vec3 c = (dir.y >= 0.0) ? stars(dir) : vec3(0);
    c += vec3(clamp(pow(clamp(dot(normalize(vec3(1,1,1)), dir), 0.0, 1.0), 256.0) * 0.2, 0.0, 0.02)); // full moon
    c += pow(1.0 - abs(dir.y), 4.0) * 0.03 * LDR_to_HDR(vec3(11.0/255.0, 24.0/255.0, 56.0/255.0)); // horizon gradient
    return fog(dir, c);
}
vec3 background_hdr(vec3 dir) { // specular
    return background_ldr(dir);
}
vec3 background_diffuse(vec3 dir) {
    return background_hdr(dir); // TODO: convolute?
}

// TODO
vec3 snow_noise(vec3 p) {
    //return normalize(vec3(1.0 + noise(p), 1.0 + noise(p*1.13), 1.0 + noise(p*0.97))); //return vec3(cos(p.x*7.17)*cos(p.z*3.13), cos(p.y*3.71), cos(p.z*5.71));
    vec3 c = texture(iChannel3, p*7.7).xyz * texture(iChannel3, p*77.7).xyz; // TODO
    return c*c;
}

// Snow, returns xyz=diffuse, w=specular. Very ad hoc.
vec4 gen_snow(vec3 ro, vec3 rd, vec3 p, inout vec3 n) {
    vec3 normal = normalize(n + snow_noise(p)*0.5);
    float diff = 0.5 + 0.5*snow_noise(1.17*p).x; //texture(iChannel2, 0.7*p.xz).r * texture(iChannel2, 7.7*p.xz);
    diff = pow(diff, 0.5);
    float spec = 0.01; // + pow(max(0.0, 1.0 - dot(normal, -rd)), 64.0);
    n = normal;
    return vec4(diff * vec3(1.0 - spec), spec);
}

// Ground plane color, snow!
vec3 planeground(vec3 ro, vec3 rd, vec3 p, inout vec3 n) {
    return gen_snow(ro, rd, p, n).rgb;
}

//-------------------------------------------------------------------------------
// Snowing by HeGu: https://www.shadertoy.com/view/4dl3R4
// This shader useds noise shaders by stegu -- http://webstaff.itn.liu.se/~stegu/
// This is supposed to look like snow falling, for example like http://24.media.tumblr.com/tumblr_mdhvqrK2EJ1rcru73o1_500.gif

vec2 mod289(vec2 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 mod289(vec3 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
    return mod289(((x*34.0)+1.0)*x);
}

vec4 permute(vec4 x) {
    return mod((34.0 * x + 1.0) * x, 289.0);
}

vec4 taylorInvSqrt(vec4 r)
{
    return 1.79284291400159 - 0.85373472095314 * r;
}

float snoise(vec2 v)
{
        const vec4 C = vec4(0.211324865405187,0.366025403784439,-0.577350269189626,0.024390243902439);
        vec2 i  = floor(v + dot(v, C.yy) );
        vec2 x0 = v -   i + dot(i, C.xx);
        
        vec2 i1;
        i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
        vec4 x12 = x0.xyxy + C.xxzz;
        x12.xy -= i1;
        
        i = mod289(i); // Avoid truncation effects in permutation
        vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
            + i.x + vec3(0.0, i1.x, 1.0 ));
        
        vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
        m = m*m ;
        m = m*m ;
        
        vec3 x = 2.0 * fract(p * C.www) - 1.0;
        vec3 h = abs(x) - 0.5;
        vec3 ox = floor(x + 0.5);
        vec3 a0 = x - ox;
        
        m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
        
        vec3 g;
        g.x  = a0.x  * x0.x  + h.x  * x0.y;
        g.yz = a0.yz * x12.xz + h.yz * x12.yw;

        return 130.0 * dot(m, g);		
}

float cellular2x2(vec2 P)
{
        const float K=0.142857142857; // 1/7
        const float K2=0.0714285714285; // K/2
        const float jitter=0.8; // jitter 1.0 makes F1 wrong more often
        
        vec2 Pi = mod(floor(P), 289.0);
        vec2 Pf = fract(P);
        vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
        vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);
        vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
        p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));
        vec4 ox = mod(p, 7.0)*K+K2;
        vec4 oy = mod(floor(p*K),7.0)*K+K2;
        vec4 dx = Pfx + jitter*ox;
        vec4 dy = Pfy + jitter*oy;
        vec4 d = dx * dx + dy * dy; // d11, d12, d21 and d22, squared
        // Sort out the two smallest distances
        
        // Cheat and pick only F1
        d.xy = min(d.xy, d.zw);
        d.x = min(d.x, d.y);
        return d.x; // F1 duplicated, F2 not computed
}

float fbm(vec2 p) {
    float f = 0.0;
    float w = 0.5;
    for (int i = 0; i < 5; i ++) {
                f += w * snoise(p);
                p *= 2.;
                w *= 0.5;
    }
    return f;
}

vec3 snowing_layer_2d( in vec2 fragCoord )
{
    float speed=2.0;
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    uv.x*=(iResolution.x/iResolution.y);
    
    vec2 suncent=vec2(0.3,0.9);
    
    float suns=(1.0-distance(uv,suncent));
    suns=clamp(0.2+suns,0.0,1.0);
    float sunsh=smoothstep(0.85,0.95,suns);

    float slope;
    slope=0.8+uv.x-(uv.y*2.3);
    slope=1.0-smoothstep(0.55,0.0,slope);								
    
    float noise=abs(fbm(uv*1.5));
    slope=(noise*0.2)+(slope-((1.0-noise)*slope*0.1))*0.6;
    slope=clamp(slope,0.0,1.0);
                            
    vec2 GA;
    GA.x-=iTime*1.8;
    GA.y+=iTime*0.9;
    GA*=speed;

    float F1=0.0,F2=0.0,F3=0.0,F4=0.0,F5=0.0,N1=0.0,N2=0.0,N3=0.0,N4=0.0,N5=0.0;
    float A=0.0,A1=0.0,A2=0.0,A3=0.0,A4=0.0,A5=0.0;


    // Attentuation
    A = (uv.x-(uv.y*0.3));
    A = clamp(A,0.0,1.0);

    // Snow layers, somewhat like an fbm with worley layers.
    F1 = 1.0-cellular2x2((uv+(GA*0.1))*8.0);	
    A1 = 1.0-(A*1.0);
    N1 = smoothstep(0.998,1.0,F1)*1.0*A1;	

    F2 = 1.0-cellular2x2((uv+(GA*0.2))*6.0);	
    A2 = 1.0-(A*0.8);
    N2 = smoothstep(0.995,1.0,F2)*0.85*A2;				

    F3 = 1.0-cellular2x2((uv+(GA*0.4))*4.0);	
    A3 = 1.0-(A*0.6);
    N3 = smoothstep(0.99,1.0,F3)*0.65*A3;				

    F4 = 1.0-cellular2x2((uv+(GA*0.6))*3.0);	
    A4 = 1.0-(A*1.0);
    N4 = smoothstep(0.98,1.0,F4)*0.4*A4;				

    F5 = 1.0-cellular2x2((uv+(GA))*1.2);	
    A5 = 1.0-(A*1.0);
    N5 = smoothstep(0.98,1.0,F5)*0.25*A5;				
                    
    float Snowout=N5+N4+N3+N2+N1;
                    
    //Snowout = 0.35+(slope*(suns+0.3))+(sunsh*0.6)+N1+N2+N3+N4+N5;
    Snowout = 0.35+slope*0.3+N1+N2+N3+N4+N5;

    return vec3(Snowout*0.9, Snowout, Snowout*1.1);
}

//-------------------------------------------------------------------------------
// Christmas tree by TekF: https://www.shadertoy.com/view/wtd3D4

// reduce this to improve frame rate in windowed mode
#define AA_QUALITY .5
// allow a little bleed between pixels - I think this looks more photographic, but blurrier
#define AA_ROUND true
#define AA_ROUND_RADIUS 0.7071

// hashes from https://www.shadertoy.com/view/4dVBzz
#define M1 1597334677U     //1719413*929
#define M2 3812015801U     //140473*2467*11
#define M3 3299493293U     //467549*7057

#define F0 exp2(-32.)
#define hash(n) n*(n^(n>>15))

#define coord1(p) (p*M1)
#define coord2(p) (p.x*M1^p.y*M2)
#define coord3(p) (p.x*M1^p.y*M2^p.z*M3)

float hash1(uint n){return float(hash(n))*F0;}
vec2  hash2(uint n){return vec2(hash(n)*uvec2(0x1U,0x3fffU))*F0;}
vec3  hash3(uint n){return vec3(hash(n)*uvec3(0x1U,0x1ffU,0x3ffffU))*F0;}
vec4  hash4(uint n){return vec4(hash(n)*uvec4(0x1U,0x7fU,0x3fffU,0x1fffffU))*F0;}

float TreeBoundsSDF( vec3 pos )
{
    // just a cone
    float r = length(pos.xz);
    return max( dot( vec2(pos.y-7.,r), normalize(vec2(.3,1)) ), -pos.y+1.8+r*.6 );
}

/*
Warp space into a series of repeated cells ("branches") around the y axis
This causes some distortion, causing marching errors near the axis when branches are
particularly sparse. But this can be worked round by tweaking the SDF.

Cells are mirrored so whatever's placed in them will tile with itself!

yByOutStep - tilts branches along the axis, but breaks vertical tiling.
*/
vec3 HelixGrid( out ivec2 grid, vec3 pos, int numSpokes, float yStepPerRotation, float yByOutStep )
{
    // convert to polar coordinates
    vec3 p = vec3(atan(pos.x,pos.z),pos.y,length(pos.xz));

    p.y -= yByOutStep*p.z;
    float l = sqrt(1.+yByOutStep*yByOutStep);
    
    // draw a grid of needles
    vec2 scale = vec2(6.283185/float(numSpokes),yStepPerRotation);
    p.xy /= scale;
    
    // rotate and skew the grid to get a spiral with nice irrational period
    float sn = 1./float(numSpokes); // so we step by an integer number of rows

    p.xy += p.yx*vec2(-1,1)*sn;
   
    // make horizontal triangle-waved, so edges of cells match up no matter what's put inside them!
    grid = ivec2(floor(p.xy));
    vec2 pair = fract((p.xy + 1.)*.5)*2.-1.;
    p.xy = (abs(pair)-.5);
    vec2 flip = step(0.,pair)*2.-1.; // sign() but without a 0.
    p.xy *= scale;

    // unshear...
    p.y += flip.y*yByOutStep*p.z;
    
    // reconstruct a non-bent space
    p.xz = p.z*vec2(sin(p.x),cos(p.x));

    // ...and apply rotation to match the shear (now we've sorted out the grid stuff)
    p.yz = ( p.yz + flip.yy*p.zy*vec2(-1,1)*yByOutStep )/l; // dammit - I think it breaks the wrap
    
// might be worth returning a bound on y to mask the discontinuous area
// I think it will just be yByAngleStep/sqrt(1.+yByOutStep*yByOutStep) which caller can do if desired
// Or, could make z NOT start at 0 - so caller has to bound using parent-level's length (totally viable and I'm doing it a lot)
// so mirroring WOULD line up!
    
    return p;
}

struct TreeSpace
{
    vec3 branch;
    vec3 twig;
    vec3 needle;
    ivec2 branchGrid;
    ivec2 twigGrid;
    ivec2 needleGrid;
};

TreeSpace GetTreeSpace( in vec3 pos )
{
    TreeSpace o;
    o.branch    = HelixGrid( o.branchGrid, pos, 12, .5, .5 );
    o.twig      = HelixGrid( o.twigGrid, o.branch.xzy, 5, .5, 1. );
    o.needle    = HelixGrid( o.needleGrid, o.twig.xzy, 9, .04, 1. );   
    return o;
}

float TreeSDF( vec3 pos )
{
    float bounds = TreeBoundsSDF(pos);   
    if ( bounds > 1. ) return bounds;
    
	TreeSpace ts = GetTreeSpace(pos);

	float branchRand = hash1(coord2(uvec2(ts.branchGrid+0x10000)));
    float branchEndLength = .3*(branchRand-.5);
    
    return
        min(
            max(
                min(
                    min(
                        // twig
                        length(ts.twig.xy)-.005,
                        // needle
                        length( vec3( ts.needle.xy, max(0.,ts.needle.z-.05) ) ) - .003
                    ),
                    // branch
                    max(
                    	(length(ts.branch.xy
                               + .004*sin(vec2(0,6.283/4.)+ts.branch.z*6.283/.1) // spiral wobble
                              )-.01)*.9,
                    	bounds - branchEndLength - .2 // trim branches shorter than twigs
                    )
            	),
            	// branch length (with rounded tip to clip twigs nicely)
                length( vec3(ts.branch.xy,max(0.,bounds
                                              -branchEndLength  // this seems to cause more floating twigs (or more obvious ones)
                                             )) )-.3
            ),
            max(
                // trunk
                length(pos.xz)-.03,
                bounds  // this will give a sharp point - better to just chop it - but might not show it
            )
        )*.7; // the helical distortion bends the SDF, so gradient can get higher than 1:1
}

// baubles only spawn in negative areas of this mask
float BaubleBoundsSDF( vec3 pos )
{
    return abs(TreeBoundsSDF(pos))-.3; // half the width of the area bauble centres can be placed in
}

// pass different seeds and densities to generate different sets of baubles
// if spacing = radius*2. the baubles will lie on a grid touching each other
float BaublesSDF( vec3 pos, uint seed, float spacing, float radius, float power, float twist )
{
    // avoid looping over every bauble - find closest one from a handful of candidates, using a jittered grid
    float f = BaubleBoundsSDF(pos);
    f -= radius;
    
    float margin = .1; // distance at which to start computing bauble SDFs - affects speed of marching (trial and error suggests .1 is fairly optimal)
    if ( f > margin ) return f;
    
	vec3 offset = spacing*(hash3(coord1(seed))-.5); // use a different grid for each set of baubles
	pos += offset;

    // find closest centre point
    vec3 c = floor(pos/spacing);
    ivec3 ic = ivec3(c);
    c = (c+.5)*spacing; // centre of the grid square
    
    c += (spacing*.5 - radius /*- margin*/) * ( hash1(coord3(uvec3(ic+63356))^seed)*2. - 1. );
    
    // cull it if it's outside bounds
    if ( BaubleBoundsSDF(c-offset) > 0. ) return margin; // could do max (margin, distance to grid cell edge)
    
    vec3 v = pos-c;
    v.xz = v.xz*cos(v.y*twist) + v.zx*vec2(1,-1)*sin(v.y*twist);
    v = abs(v)/radius;
    f = (pow(dot(v,pow(v,vec3(power-1.))),1./power)-1.)*radius;
    return min( f, margin ); // don't return values > margin otherwise we'll overshoot in next cell!
}

float Baubles1( vec3 pos ) { return BaublesSDF( pos, 0x1002U, .8, .08, 2.1, -150. ); }
float Baubles2( vec3 pos ) { return BaublesSDF( pos, 0x2037U, 1., .08, 1.2, -45. ); }
float Baubles3( vec3 pos ) { return BaublesSDF( pos, 0x3003U, .8, .08, 1.8, 50. ); }

float Ground( vec3 pos )
{
    return length(pos-vec3(0,-2,0))-2.-1.7 + .003*textureLod(iChannel2,pos.xz*5.,0.).x - .04*textureLod(iChannel2,pos.xz*.4,0.).x;
}

float SDF( vec3 pos )
{
    return min(min(min(min(
        	TreeSDF(pos),
        	Baubles1(pos)),
        	Baubles2(pos)),
        	Baubles3(pos)),
        	Ground(pos));
}


// assign a material index to each of the SDFs
// return whichever one we're closest to at this point in space
int GetMat( vec3 pos )
{
    struct MatDist { int mat; float dist; };
    MatDist mats[] = MatDist[](
        	MatDist( 0, TreeSDF(pos) ),
        	MatDist( 1, Baubles1(pos) ),
        	MatDist( 2, Baubles2(pos) ),
        	MatDist( 3, Baubles3(pos) ),
        	MatDist( 4, Ground(pos) )
        );
    
    MatDist mat = mats[0];
    for ( int i=1; i < mats.length(); i++ )
    {
        if ( mats[i].dist < mat.dist ) mat = mats[i];
    }
    
    return mat.mat;
}


float epsilon = .0004; // todo: compute from t everywhere it's used (see "size of pixel"\/\/)
int loopCount = 400; // because of the early out this can actually be pretty high without costing much

float Trace( vec3 rayStart, vec3 rayDirection, float far, out int count )
{
	float t = epsilon;
    for ( int i=0; i < loopCount; i++ )
    {
        float h = SDF(rayDirection*t+rayStart);
        t += h;
        if ( t > far || h < epsilon ) // *t )
            return t;
    }
    
    return t;
}

// Trace the tree in 3D space
// @returns color in .xyz and hit distance in .w
vec4 trace_tree(vec3 camPos, vec3 ray, float far) {
    int count = 0;
    float t = Trace( camPos, ray, far, count );
    if(t >= far) return vec4(0,0,0,NOHIT);
    
    vec3 pos = camPos + t*ray;
    vec3 uvw = pos;
    int matIdx = GetMat(uvw);

    vec2 d = vec2(-1,1) * t / iResolution.y;
    vec3 normal = normalize(
            SDF(pos+d.xxx)*d.xxx +
            SDF(pos+d.xyy)*d.xyy +
            SDF(pos+d.yxy)*d.yxy +
            SDF(pos+d.yyx)*d.yyx
        );
    
    struct Material
    {
        vec3 albedo;
        vec3 subsurfaceColour;
        float metallicity;
        float roughness; // blurriness of the metallicity
    };
        
    Material mat = Material[](
        Material( vec3(0/*overridden*/), vec3(0/*overridden*/), 0., 0. ), // tree
        Material( vec3(1,.7,.5), vec3(0), .5, .7 ),
        Material( vec3(1,.4,.1), vec3(0), 1., .0 ),
        Material( vec3(1,.1,.15), vec3(0), 1., .4 ),
        Material( vec3(.9)*smoothstep(-.8,1.5,TreeBoundsSDF(uvw)), vec3(.2), .0, .05 ) // not getting enough shine on the snow so make it metallic
    )[matIdx]; // is this bad? I kind of like it!

    if ( matIdx == 3 )
    {
        // glitter bauble / snow
        normal += .4*(hash3(coord3(uvec3(pos/.002 + 65536.)))-.5);
        normal = normalize(normal);
    }
    
    vec3 refl = reflect( ray, normal );
    
    // very broad AO - just use the tree's bound SDF
    float AO = exp2(min(0.,TreeBoundsSDF(uvw)-.3)/.3);
    
    TreeSpace ts = GetTreeSpace(uvw);
    if ( matIdx == 0 )
    {
        // compute tree albedo           
        float leafness = smoothstep(.0,.05, ts.needle.z) // // gradient along needle
                        * smoothstep(.01,.04, length(ts.branch.xy))
                        * smoothstep(.03,.06, length(uvw.xz));
        
        // blend wood to leaf colour
        mat.albedo = mix( vec3(.05,.025,.01), vec3(0,.3,0), leafness );
        mat.subsurfaceColour = mix( vec3(0), vec3(.04,.5,0), leafness );
        
        // snow
        float snow = textureLod(iChannel2,pos.xz/.02,log2(t/iResolution.x)+13.).r;
        snow = smoothstep(.1,.5,normal.y*.1+snow-.3*(1.-AO));
        mat.albedo = mix( mat.albedo, vec3(1), snow );
        mat.subsurfaceColour = mix( mat.subsurfaceColour, vec3(.1), snow );
        
        // and use the same things to paint the albedo trunk/branch colours
        mat.roughness = .7;
    }
        
    // fake reflection of the tree
    // I can probably afford a reflection trace - but I want to blur it based on roughness
    float SO = smoothstep(-1.,1.,(TreeBoundsSDF(uvw + refl*1.)
                                        -1.*(texture(iChannel2,refl.yz*2.,0.).r*2.-.7)*pow(1.-mat.roughness,5.)
                                    +.4)/(1.*(mat.roughness+.3))
                            );
    
    vec3 diffuseLight = background_diffuse(normal.xyz);
    
    // sub surface scattering
    vec3 subsurfaceSample = background_diffuse(-normal.xyz);
    diffuseLight += mat.subsurfaceColour * subsurfaceSample.rgb;
    
    diffuseLight *= AO;
    
    vec3 specularLight = mix(4.,9.,mat.roughness) * background_hdr(refl);
    specularLight = mix( vec3(.01,.02,.0)+.0, specularLight, SO ); // blend to a rough tree colour
    
    float fresnel = pow(1.-abs(dot(ray,normal)),5.);
    
    return vec4(
        mix(
            mix ( mat.albedo, vec3(1.), mat.metallicity*(1.-mat.roughness)*fresnel ) *
            mat.albedo *
            mix(
                diffuseLight,
                specularLight,
                mat.metallicity
            ),
            specularLight,
            mix( .02, 1., fresnel )*(1.-mat.roughness)
        ), 
        t);
}


//-------------------------------------------------------------------------------

// Look from origin "o" to target point "p" with up vector "up"
mat4 lookat(in vec3 o, in vec3 p, in vec3 up, float rotate)
{
    vec3 delta = p - o;
    up = vec3(sin(rotate), cos(rotate), 0.0); // TODO: overwrites actual up, if not (0,1,0)..
    vec3 z = normalize(delta); // the direction to look at (Z-axis)
    vec3 x = normalize(cross(z, up)); // -> to-right direction (X-axis)
    vec3 y = normalize(cross(x, z)); // -> to-up direction (Y-axis)
    return mat4(
        vec4(x.xyz, -dot(o,x)),
        vec4(y.xyz, -dot(o,y)),
        vec4(z.xyz, -dot(o,z)),
        vec4(0,0,0, 1));
}

// Transform a 3D direction vector by a 4x4 matrix
vec3 transform_dir(vec3 dir, mat4 m) {
    return (m * vec4(dir, 0.0)).xyz;
}

// Find an intersection between ray ro+t*rd, where t=[0, <NOHIT]
// and a sphere located at "p" with radius "r".
//
// If hits, returns "t", otherwise NOHIT.
float isect_ray_sphere(in vec3 ro, in vec3 rd, in vec3 p, in float r) {
    vec3 oc = ro - p;
    float b = dot(oc, rd);
    float c = dot(oc, oc) - r*r;
    float t = b*b - c;
    float t2 = (t > 0.0) ? -b - sqrt(t) : NOHIT;
    return (t2 > 0.0) ? t2 : NOHIT;
}

// Find an intersection between ray ro+t*rd, where t=[0, <NOHIT]
// and a plane going through point "p" with normal "n".
//
// If hits, returns t >= 0.0, otherwise NOHIT.
float isect_ray_plane(in vec3 ro, in vec3 rd, in vec3 p, in vec3 n) {
    
    float denom = dot(rd, -n);
    return (denom > 0.0) ? -dot(p - ro, n) / denom : NOHIT;
}

// Find an intersection between ray ro+t*d and a cone
float isect_ray_cone(in vec3 ro, in vec3 rd, in vec3 pa, in vec3 pb, float ra, float rb) {
    vec4 v = iCappedCone(ro, rd, pa, pb, ra, rb);
    if(v.x < 0.0) v.x = NOHIT;
    return v.x;
}

//-------------------------------------------------------------------------------

// Animate sphere positions
vec3 sphere_center(int n) {
    // snowman!
    const float speed = 0.0; //0.1;
    const float phase = 0.0;
    float r = sphere_radius[n];
    vec3 p;
    p.x = sin(phase + speed*iTime)*sphere_dist;
    p.z = cos(phase + speed*iTime)*sphere_dist;
    p.y = plane_alt + sphere_alt[n];

/*
    // and.. bounce!
    float ifreq = 2.*PI;
    float dur = 0.75*4.;
    float t = (mod(iTime, ifreq) - (ifreq-dur)) / dur; // [0,1] if bouncing
    if(t >= 0.0) p.y += abs(sin(t*PI)*jump_altitude); // jump!
*/
    return p;
}

//-------------------------------------------------------------------------------

// Returns "t" if hits something, otherwise NOHIT
float hit(in vec3 ro, in vec3 rd, out vec3 hitp, out vec3 hitn, out int id) {
    // scene: 3 spheres + plane
    vec3 scenter1 = sphere_center(0);
    vec3 scenter2 = sphere_center(1);
    vec3 scenter3 = sphere_center(2);
    vec3 carrotce = scenter3 + vec3(0, 0, -0.3);

    float sphe1_t = isect_ray_sphere(ro, rd, scenter1, sphere_radius[0]);
    float sphe2_t = isect_ray_sphere(ro, rd, scenter2, sphere_radius[1]);
    float sphe3_t = isect_ray_sphere(ro, rd, scenter3, sphere_radius[2]);
    float plane_t = isect_ray_plane(ro, rd, vec3(0,plane_alt,0), planen);
    float carro_t = isect_ray_cone(ro, rd, scenter3, carrotce, 0.05, 0.01);
    
    float t = min(sphe1_t, min(sphe2_t, min(sphe3_t, min(plane_t, carro_t)))); // closest hit or NOHIT
    hitp = ro + t*rd; // world hit point

    // object id + world hit normal
    if( t == NOHIT   ) { id = ID_NONE;     hitn = -rd; } else
    if( t == sphe1_t ) { id = ID_SPHERE01; hitn = normalize(hitp - scenter1); } else
    if( t == sphe2_t ) { id = ID_SPHERE02; hitn = normalize(hitp - scenter2); } else
    if( t == sphe3_t ) { id = ID_SPHERE03; hitn = normalize(hitp - scenter3); } else
    if( t == plane_t ) { id = ID_PLANE;    hitn = planen; } else
    if( t == carro_t ) { id = ID_CARROTCONE; hitn = normalize(hitp - carrotce); } // TODO

    // add some epsilon to position to compensate floating point inaccuracies
    hitp += EPSILON*hitn;
    return t;
}

// TODO:
vec3 trace2(in vec3 ro, in vec3 rd) {
    const int maxdepth = 3;
    uint rs = uint(rd.x + rd.y + rd.z); // TODO: better seed?
    for(int depth=0; depth < maxdepth; ++depth) {
        int id;
        vec3 hitp; // world position of hit point
        vec3 hitn; // world normal of hit point
        float t = hit(ro, rd, hitp, hitn, id); // sets "hitp", "hitn", "id"

        switch(id) {
            case ID_SPHERE01:
            case ID_SPHERE02:
            case ID_SPHERE03: {
                // hits a sphere - 100% reflective, so continue path to reflection direction
                vec3 reflection = normalize(reflect(rd, hitn)); // reflect the ray around sphere normal
                ro = hitp;
                rd = reflection;
                break;
            }
            default:
                // misses scene objects -> background, terminate path
                return background_hdr(rd);
        }
    }
}

// return 0.0, if occluded to direction, otherwise 1.0
float occlusion(in vec3 ro, in vec3 rd) {
    vec3 unused_p; vec3 unused_n; int unused_id;
    float hitt = hit(ro, rd, unused_p, unused_n, unused_id); // 1.0 if unblocked
    return (hitt < NOHIT) ? 0.0 : 1.0; // TODO: distance mix?
}

// sample hemisphere for irradiance
vec3 hemilighting(in vec3 hitp, in vec3 hitn) {
    vec3 hemidir = random_hemisphere_dir(hitn); // world space                  
    float occlusion = occlusion(hitp, hemidir); // check if hits something
    vec3 irradiance = occlusion * background_diffuse(hemidir);
    return irradiance;
}

// mix
vec3 mixsum(in vec4 sum, in vec3 c) {
    return sum.xyz + c.xyz*(1.0 - sum.w);
}

// path tracing
vec3 trace(in vec3 ro, in vec3 rd) {
    const int maxdepth = 3;
    vec4 sum = vec4(0);
    for(int depth=0; depth < maxdepth; ++depth) {
        int id;
        vec3 hitp; // world position of hit point
        vec3 hitn; // world normal of hit point
        float t = hit(ro, rd, hitp, hitn, id); // sets "hitp", "hitn", "id"

        vec4 tree = trace_tree(ro, rd, 10.0); // the christmas tree
        if( tree.w < t ) {
            return mixsum(sum, tree.xyz);
        }

        switch(id) {
            case ID_SPHERE01:
            case ID_SPHERE02:
            case ID_SPHERE03: {
                // hits a sphere - semi-reflective, so continue path to reflection direction
                vec4 snow = gen_snow(ro, rd, hitp, hitn); // note: changes hitn
                sum.xyz += snow.rgb * hemilighting(hitp, hitn) * vec3(10.0);
                sum.w += 1.0 - snow.w;

                vec3 reflection = normalize(reflect(rd, hitn));
                ro = hitp;
                rd = reflection;
                
                break;
            }
            case ID_CARROTCONE: {
                // Emissive Snowman Carrot!
                vec3 emissive = 0.01*LDR_to_HDR(vec3(179.0/255.0, 95.0/255.0, 28.0/255.0));
                return emissive;
            }
            default:
                // make up circular floor plane area
                if( id == ID_PLANE && length(hitp) < plane_radius ) { 
                    vec3 irradiance = hemilighting(hitp, hitn) * vec3(10.0);
                    vec3 tex = planeground(ro, rd, hitp, hitn); // note: changes hitn
                    vec3 pc = irradiance * tex;
                    //return mixsum(sum, mix(pc, background_hdr(rd), min(1., t/FADE_DIST)));
                    return mixsum(sum, fog(rd, pc));
                } else { 
                    // misses scene objects -> background, terminate path
                    return mixsum(sum, background_hdr(rd));
                }
        }
    }
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    seed = iTime + iResolution.y * fragCoord.x / iResolution.x + fragCoord.y / iResolution.y; // initialize random seed
    vec2 rotation = vec2(iMouse.x/iResolution.x, 0.0); // Mouse [0,1]
    vec2 p = (2.0*fragCoord.xy - iResolution.xy) / iResolution.y; // Pixel coordinates y=[-1,1], x=[-1*aspect,1*aspect] where aspect=width/height
    
    float look_mix = 0.5 + 0.5*sin(0.1*iTime);
    vec3 look_to = mix(sphere_center(0), camera_look_at_tree, look_mix); // TODO
    
    if(iMouse.z <= 0.0) rotation.x = sin(0.02*iTime*0.6);
    vec3 ro = vec3(sin(-rotation.x*TWO_PI)*camera_distance, camera_alt, cos(-rotation.x*TWO_PI)*camera_distance); // Mouse rotation around the sphere -> ray origin (camera position)  
    mat4 m = lookat(ro, look_to, vec3(0,1,0), 0.07*cos(0.25*iTime)); // Camera->World transformation matrix

    // simple over-the-top adhoc DOF, TODO: better one
    float dofi = 135.0/iResolution.y;
    float dofa = rnd() * TWO_PI;
    float dofr = rnd() * dofi;
    ro += (m * vec4(cos(dofa)*dofr, sin(dofa)*dofr, 0.0, 1.0)).xyz;
    m = lookat(ro, look_to, vec3(0,1,0), 0.07*cos(0.25*iTime));

    vec3 ldir = normalize(vec3(p, 1.0)); // Local ray direction (Camera Space)
    vec3 rd = transform_dir(ldir, m); // -> World Space
    

    // trace multiple samples per pixel, average
    vec3 c = vec3(0);
    for(int i=0; i < NUM_SAMPLES; ++i) {
        vec2 jitter;
        jitter.x = 1.5/iResolution.x * rnd();
        jitter.y = 1.5/iResolution.y * rnd();
        vec3 offset = (m * vec4(jitter.x, jitter.y, 0.0, 1.0)).xyz;
        
        vec3 s = trace(ro + offset, rd);
        c += s;
    }
    c /= float(NUM_SAMPLES);
    c = pow(c, vec3(0.5)); // some curve.. TODO:
    c.rgb *= EXPOSURE;
    c.rgb = HDR_to_LDR( c.rgb );

    // snow effect on top
    c += snowing_layer_2d(fragCoord);
    
    // vignette and like
    vec2 uv = fragCoord.xy / iResolution.xy;
    c *= 0.5 + 0.5*pow(abs(16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y)), 0.20);
 
    // TODO: temporal AA
   
    c = 1.0 - exp(-c*3.0);
     
    fragColor = vec4(c, 1.0);
}