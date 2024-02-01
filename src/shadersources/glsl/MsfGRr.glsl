// Copyright Inigo Quilez, 2013 - https://iquilezles.org/
// I am the sole copyright owner of this Work.
// You cannot host, display, distribute or share this Work in any form,
// including physical and digital. You cannot use this Work in any
// commercial or non-commercial product, website or project. You cannot
// sell this Work and you cannot mint an NFTs of it.
// I share this Work for educational purposes, and you can link to it,
// through an URL, proper attribution and unmodified screenshot, as part
// of your educational material. If these conditions are too restrictive
// please contact me and we'll definitely work it out.

// A port of my 2007 demo Kindernoiser: https://www.youtube.com/watch?v=9AX8gNyrSWc (http://www.pouet.net/prod.php?which=32549)
//
// Info here:
//    https://iquilezles.org/articles/juliasets3d
//
//
// Related shaders
//
// Julia - Quaternion 1 : https://www.shadertoy.com/view/MsfGRr
// Julia - Quaternion 2 : https://www.shadertoy.com/view/lsl3W2
// Julia - Quaternion 3 : https://www.shadertoy.com/view/3tsyzl

// antialias level (1, 2, 3...)
#if HW_PERFORMANCE==1
#define AA 1
#else
#define AA 2  // Set AA to 1 if your machine is too slow
#endif


// Normals computation:
// 0: numerical gradient of d
// 1: numerical gradient of G
// 2: analytic  gradient of G
// 3: analytic  gradient of G optimized
#define METHOD 3

vec4 qsqr( in vec4 a ) // square a quaterion
{
    return vec4( a.x*a.x - a.y*a.y - a.z*a.z - a.w*a.w,
                 2.0*a.x*a.y,
                 2.0*a.x*a.z,
                 2.0*a.x*a.w );
}
vec4 qmul( in vec4 a, in vec4 b)
{
    return vec4(
        a.x * b.x - a.y * b.y - a.z * b.z - a.w * b.w,
        a.y * b.x + a.x * b.y + a.z * b.w - a.w * b.z, 
        a.z * b.x + a.x * b.z + a.w * b.y - a.y * b.w,
        a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y );

}
vec4 qconj( in vec4 a )
{
    return vec4( a.x, -a.yzw );
}
float qlength2( in vec4 q )
{
    return dot(q,q);
}

const int numIterations = 11;

float map( in vec3 p, out vec4 oTrap, in vec4 c )
{
    vec4 z = vec4(p,0.0);
    float md2 = 1.0;
    float mz2 = dot(z,z);

    vec4 trap = vec4(abs(z.xyz),dot(z,z));

    float n = 1.0;
    for( int i=0; i<numIterations; i++ )
    {
        // dz -> 2·z·dz, meaning |dz| -> 2·|z|·|dz|
        // Now we take the 2.0 out of the loop and do it at the end with an exp2
        md2 *= 4.0*mz2;
        // z  -> z^2 + c
        z = qsqr(z) + c;  

        trap = min( trap, vec4(abs(z.xyz),dot(z,z)) );

        mz2 = qlength2(z);
        if(mz2>4.0) break;
        n += 1.0;
    }
    
    oTrap = trap;

    return 0.25*sqrt(mz2/md2)*log(mz2);  // d = 0.5·|z|·log|z|/|z'|
}

#if METHOD==0
vec3 calcNormal( in vec3 p, in vec4 c )
{
#if 1
    vec2 e = vec2(1.0,-1.0)*0.5773*0.001;
    vec4 za=vec4(p+e.xyy,0.0); float mz2a=qlength2(za), md2a=1.0;
    vec4 zb=vec4(p+e.yyx,0.0); float mz2b=qlength2(zb), md2b=1.0;
    vec4 zc=vec4(p+e.yxy,0.0); float mz2c=qlength2(zc), md2c=1.0;
    vec4 zd=vec4(p+e.xxx,0.0); float mz2d=qlength2(zd), md2d=1.0;
  	for(int i=0; i<numIterations; i++)
    {
        md2a *= mz2a; za = qsqr(za)+c; mz2a = qlength2(za);
        md2b *= mz2b; zb = qsqr(zb)+c; mz2b = qlength2(zb);
        md2c *= mz2c; zc = qsqr(zc)+c; mz2c = qlength2(zc);
        md2d *= mz2d; zd = qsqr(zd)+c; mz2d = qlength2(zd);
    }
    return normalize( e.xyy*sqrt(mz2a/md2a)*log2(mz2a) + 
					  e.yyx*sqrt(mz2b/md2b)*log2(mz2b) + 
					  e.yxy*sqrt(mz2c/md2c)*log2(mz2c) + 
					  e.xxx*sqrt(mz2d/md2d)*log2(mz2d) );
#else    
    const vec2 e = vec2(0.001,0.0);
    vec4 za=vec4(p+e.xyy,0.0); float mz2a=qlength2(za), md2a=1.0;
    vec4 zb=vec4(p-e.xyy,0.0); float mz2b=qlength2(zb), md2b=1.0;
    vec4 zc=vec4(p+e.yxy,0.0); float mz2c=qlength2(zc), md2c=1.0;
    vec4 zd=vec4(p-e.yxy,0.0); float mz2d=qlength2(zd), md2d=1.0;
    vec4 ze=vec4(p+e.yyx,0.0); float mz2e=qlength2(ze), md2e=1.0;
    vec4 zf=vec4(p-e.yyx,0.0); float mz2f=qlength2(zf), md2f=1.0;
  	for(int i=0; i<numIterations; i++)
    {
        md2a *= mz2a; za = qsqr(za) + c; mz2a = qlength2(za);
        md2b *= mz2b; zb = qsqr(zb) + c; mz2b = qlength2(zb);
        md2c *= mz2c; zc = qsqr(zc) + c; mz2c = qlength2(zc);
        md2d *= mz2d; zd = qsqr(zd) + c; mz2d = qlength2(zd);
        md2e *= mz2e; ze = qsqr(ze) + c; mz2e = qlength2(ze);
        md2f *= mz2f; zf = qsqr(zf) + c; mz2f = qlength2(zf);
    }
    float da = sqrt(mz2a/md2a)*log2(mz2a);
    float db = sqrt(mz2b/md2b)*log2(mz2b);
    float dc = sqrt(mz2c/md2c)*log2(mz2c);
    float dd = sqrt(mz2d/md2d)*log2(mz2d);
    float de = sqrt(mz2e/md2e)*log2(mz2e);
    float df = sqrt(mz2f/md2f)*log2(mz2f);
    
    return normalize( vec3(da-db,dc-dd,de-df) );
#endif    
}
#endif

#if METHOD==1
vec3 calcNormal( in vec3 p, in vec4 c )
{
    const vec2 e = vec2(0.001,0.0);
    vec4 za = vec4(p+e.xyy,0.0);
    vec4 zb = vec4(p-e.xyy,0.0);
    vec4 zc = vec4(p+e.yxy,0.0);
    vec4 zd = vec4(p-e.yxy,0.0);
    vec4 ze = vec4(p+e.yyx,0.0);
    vec4 zf = vec4(p-e.yyx,0.0);

  	for(int i=0; i<numIterations; i++)
    {
        za = qsqr(za) + c; 
        zb = qsqr(zb) + c; 
        zc = qsqr(zc) + c; 
        zd = qsqr(zd) + c; 
        ze = qsqr(ze) + c; 
        zf = qsqr(zf) + c; 
    }
    return normalize( vec3(log2(qlength2(za))-log2(qlength2(zb)),
                           log2(qlength2(zc))-log2(qlength2(zd)),
                           log2(qlength2(ze))-log2(qlength2(zf))) );

}
#endif

#if METHOD==2
vec3 calcNormal( in vec3 p, in vec4 c )
{
    vec4 z = vec4(p,0.0);

    // identity derivative
    mat4x4 J = mat4x4(1,0,0,0,  
                      0,1,0,0,  
                      0,0,1,0,  
                      0,0,0,1 );

  	for(int i=0; i<numIterations; i++)
    {
        // chain rule of jacobians (removed the 2 factor)
        J = J*mat4x4(z.x, -z.y, -z.z, -z.w, 
                     z.y,  z.x,  0.0,  0.0,
                     z.z,  0.0,  z.x,  0.0, 
                     z.w,  0.0,  0.0,  z.x);

        // z -> z2 + c
        z = qsqr(z) + c; 
        
        if(qlength2(z)>4.0) break;
    }

    return normalize( (J*z).xyz );
}
#endif

#if METHOD==3
vec3 calcNormal( in vec3 p, in vec4 c )
{
    vec4 z = vec4(p,0.0);

    // identity derivative
    vec4 J0 = vec4(1,0,0,0);
    vec4 J1 = vec4(0,1,0,0);
    vec4 J2 = vec4(0,0,1,0);
    
  	for(int i=0; i<numIterations; i++)
    {
        vec4 cz = qconj(z);
        
        // chain rule of jacobians (removed the 2 factor)
        J0 = vec4( dot(J0,cz), dot(J0.xy,z.yx), dot(J0.xz,z.zx), dot(J0.xw,z.wx) );
        J1 = vec4( dot(J1,cz), dot(J1.xy,z.yx), dot(J1.xz,z.zx), dot(J1.xw,z.wx) );
        J2 = vec4( dot(J2,cz), dot(J2.xy,z.yx), dot(J2.xz,z.zx), dot(J2.xw,z.wx) );

        // z -> z2 + c
        z = qsqr(z) + c; 
        
        if(qlength2(z)>4.0) break;
    }
    
	vec3 v = vec3( dot(J0,z), 
                   dot(J1,z), 
                   dot(J2,z) );

    return normalize( v );
}
#endif





float intersect( in vec3 ro, in vec3 rd, out vec4 res, in vec4 c )
{
    vec4 tmp;
    float resT = -1.0;
	float maxd = 10.0;
    float h = 1.0;
    float t = 0.0;
    for( int i=0; i<300; i++ )
    {
        if( h<0.0001||t>maxd ) break;
	    h = map( ro+rd*t, tmp, c );
        t += h;
    }
    if( t<maxd ) { resT=t; res = tmp; }

	return resT;
}

float softshadow( in vec3 ro, in vec3 rd, float mint, float k, in vec4 c )
{
    float res = 1.0;
    float t = mint;
    for( int i=0; i<64; i++ )
    {
        vec4 kk;
        float h = map(ro + rd*t, kk, c);
        res = min( res, k*h/t );
        if( res<0.001 ) break;
        t += clamp( h, 0.01, 0.5 );
    }
    return clamp(res,0.0,1.0);
}

vec3 render( in vec3 ro, in vec3 rd, in vec4 c )
{
	const vec3 sun = vec3(  0.577, 0.577,  0.577 );
    
	vec4 tra;
	vec3 col;
    float t = intersect( ro, rd, tra, c );
    if( t < 0.0 )
    {
     	col = vec3(0.7,0.9,1.0)*(0.7+0.3*rd.y);
		col += vec3(0.8,0.7,0.5)*pow( clamp(dot(rd,sun),0.0,1.0), 48.0 );
	}
	else
	{
        vec3 mate = vec3(1.0,0.8,0.7)*0.3;
		//mate.x = 1.0-10.0*tra.x;
        
        vec3 pos = ro + t*rd;
        vec3 nor = calcNormal( pos, c );
        
		float occ = clamp(2.5*tra.w-0.15,0.0,1.0);
		

        col = vec3(0.0);

        // sky
        {
        float co = clamp( dot(-rd,nor), 0.0, 1.0 );
        vec3 ref = reflect( rd, nor );
        //float sha = softshadow( pos+0.0005*nor, ref, 0.001, 4.0, c );
        float sha = occ;
        sha *= smoothstep( -0.1, 0.1, ref.y );
        float fre = 0.1 + 0.9*pow(1.0-co,5.0);
            
		col  = mate*0.3*vec3(0.8,0.9,1.0)*(0.6+0.4*nor.y)*occ;
		col +=  2.0*0.3*vec3(0.8,0.9,1.0)*(0.6+0.4*nor.y)*sha*fre;
        }

        // sun
        {
        const vec3 lig = sun;
        float dif = clamp( dot( lig, nor ), 0.0, 1.0 );
        float sha = softshadow( pos, lig, 0.001, 64.0, c );
        vec3 hal = normalize( -rd+lig );
        float co = clamp( dot(hal,lig), 0.0, 1.0 );
        float fre = 0.04 + 0.96*pow(1.0-co,5.0);
        float spe = pow(clamp(dot(hal,nor), 0.0, 1.0 ), 32.0 );
        col += mate*3.5*vec3(1.00,0.90,0.70)*dif*sha;
        col +=  7.0*3.5*vec3(1.00,0.90,0.70)*spe*dif*sha*fre;
        }

        // extra fill
        {
        const vec3 lig = vec3( -0.707, 0.000, -0.707 );
		float dif = clamp(0.5+0.5*dot(lig,nor), 0.0, 1.0 );
        col += mate* 1.5*vec3(0.14,0.14,0.14)*dif*occ;
        }
        
        // fake SSS
        {
        float fre = clamp( 1.+dot(rd,nor), 0.0, 1.0 );
        col += mate* mate*0.6*fre*fre*(0.2+0.8*occ);
        }
    }

	return pow( col, vec3(0.4545) );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // anim
    float time = iTime*.15;
    vec4 c = 0.45*cos( vec4(0.5,3.9,1.4,1.1) + time*vec4(1.2,1.7,1.3,2.5) ) - vec4(0.3,0.0,0.0,0.0);

    // camera
	float r = 1.5+0.15*cos(0.0+0.29*time);
	vec3 ro = vec3(           r*cos(0.3+0.37*time), 
					0.3 + 0.8*r*cos(1.0+0.33*time), 
					          r*cos(2.2+0.31*time) );
	vec3 ta = vec3(0.0,0.0,0.0);
    float cr = 0.1*cos(0.1*time);
    
    
    // render
    vec3 col = vec3(0.0);
    for( int j=0; j<AA; j++ )
    for( int i=0; i<AA; i++ )
    {
        vec2 p = (-iResolution.xy + 2.0*(fragCoord + vec2(float(i),float(j))/float(AA))) / iResolution.y;

        vec3 cw = normalize(ta-ro);
        vec3 cp = vec3(sin(cr), cos(cr),0.0);
        vec3 cu = normalize(cross(cw,cp));
        vec3 cv = normalize(cross(cu,cw));
        vec3 rd = normalize( p.x*cu + p.y*cv + 2.0*cw );

        col += render( ro, rd, c );
    }
    col /= float(AA*AA);
    
    vec2 uv = fragCoord.xy / iResolution.xy;
	col *= 0.7 + 0.3*pow(16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y),0.25);
    
	fragColor = vec4( col, 1.0 );
}