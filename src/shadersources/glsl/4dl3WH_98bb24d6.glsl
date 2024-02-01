//between 0.0 - 1.0
#define DayLight 0.3 

//minim 5 for best result
#define Depth 5 

float freqs[4];
float side = 1.;

vec2 p,rv2;
float f0, f1,f2,f3;

vec3 rand3(vec2 fragCoord)
{
   vec4 s1 = sin(iTime * 3.3422 + fragCoord.xxxx * vec4(324.324234, 563.324234, 657.324234, 764.324234)) * 543.3423;
   vec4 s2 = sin(iTime * 1.3422 + fragCoord.yyyy * vec4(567.324234, 435.324234, 432.324234, 657.324234)) * 654.5423;
   vec4 gPixelRandom = fract(2142.4 + s1 + s2);
   return normalize( gPixelRandom.xyz - 0.5);
}

float hash( float n ) {
	return fract(sin(n)*43758.5453);}
	
vec2 hash2( float n ) {
	return fract(sin(vec2(n,n+1.0))*vec2(2.1459123,3.3490423));
}

vec2 randv2;
vec2 rand2()
{
   randv2+= randv2+vec2(1.0,1.0);
   return vec2( fract(sin(dot(randv2.xy ,vec2(12.9898,78.233))) * 43758.5453),
      			fract(cos(dot(randv2.xy ,vec2(4.898,7.23))) * 23421.631));
}

vec3 cosineDirection(in vec3 nor, vec2 fragCoord)
{//return a random direction on the hemisphere
   vec2 r = rand3(fragCoord).xy*6.283;
   vec3 dr=vec3(sin(r.x)*vec2(sin(r.y),cos(r.y)),cos(r.x));
   return (dot(dr,nor)<0.0)?-dr:dr;
}

vec3 CosineWeightedSampleHemisphere ( vec3 normal, vec2 rnd )
{
   float phi = acos( sqrt(1.0 - rnd.x)) ;
   float theta = 2.0 * 3.14 * rnd.y ;

   vec3 sdir = cross(normal, (abs(normal.x) < 0.5) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 1.0, 0.0));
   vec3 tdir = cross(normal, sdir);

   //return vec3(sin(phi) * cos(theta), cos(phi), sin(phi) * sin(theta));
   return normalize(phi * cos(theta) * sdir + phi * sin(theta) * tdir + sqrt(1.0 - rnd.x) * normal);
}

vec3 rotateY(vec3 p, float a)
{
    float sa = sin(a);
    float ca = cos(a);
    vec3 r;
    r.x = ca*p.x + sa*p.z;
    r.y = p.y;
    r.z = -sa*p.x + ca*p.z;
    return r;
}

float iplane(vec3 p, vec3 planeN, vec3 planePos)
{
   return dot(p - planePos, planeN);
}

float sphere( vec3 p, float s )
{
    return length(p)-s;
}

float cub(vec3 p,vec3 c, vec3 size)
{
   p = p-c;
   return max(max(abs(p.x) - size.x, abs(p.y) - size.y), abs(p.z) - size.z);
}

vec2 scene( vec3 p )
{
   float f = 100000.0;
   float id = -1.;

	//cub light
	float f1 = cub(p, vec3(0.0, f1*0.5+0.0, 2.0), vec3(0.2, f1*0.5+0.0, 0.1));
	if(f1<f) {f = f1; id = 0.;}	
	float f2 = cub(p, vec3(1.0, f0*0.5+0.0, 2.0), vec3(0.2, f0*0.5+0.0, 0.1));
	if(f2<f) {f = f2; id = 1.;}	
	float f3 = cub(p, vec3(-1.0, f3*0.5, 2.0), vec3(0.2, f3*0.5, 0.1));
	if(f3<f) {f = f3; id = 2.;}
	
	//transparent cub
	float f4 = cub(p, vec3(-1.5, 0.5, 0.0), vec3(0.6,0.5, 0.1));
	if(f4<f) {f = f4; id = 3.;}
	
	float n = sin(iTime)*0.5;
	//transparent sphere
	float f10 = sphere(p-vec3(0.0, n, -0.5), 0.5);
    if(f10<f) {f = f10; id = 10.;}
	
	//comvex mirror
	float m = sin(iTime)*1.5;
	float f11 = sphere(p-vec3(0.0, 0.0, m+2.5), 2.0);
	float f12 = sphere(p-vec3(0.0, 0.0, m+2.0), 2.3);
	f12 = max(f11,-f12);
	if(f12<f) {f = f12; id = 11.;}
	
	//plane
	float f20 = iplane(p, vec3(0., 1., 0.), vec3(0., -0.0, 0.));
	if(f20<f) {f = f20; id = 14.;}

   return vec2(f, id);
}

// color and power of emisiv
vec4 getMatColor(float id)
{
	vec4 color = vec4(0.);
	if(id==0.) color = vec4(0.2,0.9,0.2, f1*1.3);//cub green
	if(id==1.) color = vec4(0.2,0.2,1.0, f0*1.3);//cub blue
	if(id==2.) color = vec4(1.0,1.0,0.2, f3*1.3);//cub yelow
	if(id==3.) color = vec4(1.0,0.7,0.5, 0);//
	
	if(id==10.) color = vec4(1.0,1.0,1.0, 0.0);//sphere
	if(id==11.) color = vec4(1.0,1.0,1.0, 0.0);//convex mirror
	if(id==14.) color = vec4(1.0,1.0,1.0, 0.0);//plan
	
	return color;
}

//rflect/refract - betwen -1.0 - 1.0 and diffuse refl/refr - betwen 0.0 - 1.0
vec2 getMatRef(float id)
{
	vec2 ref = vec2(0.);
	if(id==0.) ref = vec2( 0.0,  0.0);//cub green
	if(id==1.) ref = vec2( 0.0,  0.0);//cub blue
	if(id==2.) ref = vec2( 0.0,  0.0);//cub yelow
	if(id==3.) ref = vec2(-1.0,  0.05);//transparent cub
	
	if(id==10.) ref = vec2(-1.0,  0.0);//sphere
	if(id==11.) ref = vec2( 1.0,  0.0);//convex mirror
	if(id==14.) ref = vec2( 0.0,  0.0);//plan
	
	return ref;
}

vec3 sceneNormal( in vec3 pos )
{
	vec3 eps = vec3( 0.001, 0.0, 0.0 );
	vec3 nor = vec3(
	    scene(pos+eps.xyy).x - scene(pos-eps.xyy).x,
	    scene(pos+eps.yxy).x - scene(pos-eps.yxy).x,
	    scene(pos+eps.yyx).x - scene(pos-eps.yyx).x );
	return normalize(nor);
}

vec2 raym(vec3 ro, vec3 rd, int maxit, float maxd)
{
	float d = 0.002;
	vec2 f = vec2(0.0, -1.0);
	side = sign(scene(ro+rd*0.001).x);
	
	for(int i=0; i<80; i++)
	{
		f = scene(ro+rd*d);
		if(abs(f.x) < 0.0001 || d > maxd)
		{
			f.x = d;
			continue;//return f;
		}
		d += f.x*side;
		//if(d > 5.) {f.x = 1000.;f.y = -1.0; return f;}
	}
	if(d > maxd) {f.x = 1000.;f.y = -1.0; }
	return f;//vec2(0.0, -1.0);
}

vec2 castRay( in vec3 ro, in vec3 rd, in float maxd )
{
	float precis = 0.001;
    float h=precis*20.0;
    float t = 0.0;
    float m = -1.0;
	side = sign(scene(ro+rd*0.01).x);
    for( int i=0; i<90; i++ )
    {
        if( abs(h)<precis||t>maxd ) continue;//break;
        t += h*side;
	    vec2 res =scene( ro+rd*t );
        h = res.x;
	    m = res.y;
    }

    if( t>maxd ) m=-1.0;
    return vec2( t, m );
}

const vec3 ior=vec3(1.0,1.52,1.0/1.52);
vec3 getBRDFRay( in vec3 rd, in vec3 n, in vec2 mref, vec2 fragCoord )
{
	float q = rd.x+iTime*texture( iChannel0, p*0.8 ).r;
   //randomly direct the ray in a hemisphere or cone based on reflectivity
   if( hash(q)*0.0005 > abs(mref.x))
	{
    	//vec3 dr = normalize(n + rand3(fragCoord) * 0.99);
		vec3 dr = (cosineDirection(n,fragCoord))*10.1;
    	return (dot(dr,n)<0.0)?-dr:dr;
	}
   else
   {//return a cone direction for a reflected or refracted ray
      vec3 refl=reflect(rd,n);
      vec3 newRay = refl;
      if(mref.x<0.0)
      {
         vec3 refr=refract(rd,n*side,(side>=0.0)?ior.z:ior.y); 
         vec2 ca=vec2(dot(n,rd),dot(n,refr)),ns=(side>=0.0)?ior.xy:ior.yx,nn=vec2(ns.x,-ns.y);
         if(hash2(q).x>0.5*(pow(dot(nn,ca)/dot(ns,ca),2.0)+pow(dot(nn,ca.yx)/dot(ns,ca.yx),2.0)))
			 newRay=refr;
      }
	  return normalize(newRay+cosineDirection(newRay+rand3(fragCoord),fragCoord)*mref.y)*1.5;
   }
}

vec2 min2(vec2 d1, vec2 d2){return (d1.x<d2.x)?d1:d2;}//sorts vectors based on .x

vec3 getColor (in vec3 ro, in vec3 rd, in vec2 fragCoord)
{
	vec3 tcolor = vec3(0.0);
	vec3 color  = vec3(1.0);
	vec3 n = vec3(0.,1.05,0.);
	vec3 sundir = vec3(cos(iTime*0.7)*2.5+0.2,0.9,sin(iTime*0.7)*2.5+0.2);
	vec2 hit = vec2(0.0,-1.0);

	for(int i=0; i<Depth; i++)
	{
		hit = raym(ro, rd, 80, 10.);
		
		if(hit.y==-1.)
		{
				float diff = dot(n,sundir);
				tcolor +=  color*diff*vec3(0.9,0.9,1.0)*DayLight;
				break;
		}
		
		vec4 matcol = getMatColor(hit.y);
		if(matcol.w>0.) {tcolor +=  color * (matcol.xyz*matcol.w); break;}
		
		color *= matcol.xyz;	
		tcolor +=  color * (matcol.w);
		
		ro += rd * (hit.x+0.001);
		n = sceneNormal( ro );
		rd = normalize(getBRDFRay( rd, n, getMatRef(hit.y), fragCoord));
		ro +=rd*0.0001;
	}
	
	return clamp(tcolor, 0., 1.);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    randv2 = fract(cos((fragCoord.xy+fragCoord.yx*vec2(1000.0,1000.0))+vec2(iTime*0.2,iTime*0.2))*10000.0);
    
	vec2 q = fragCoord.xy/iResolution.xy;
    p = -1.0+2.0*q;
	p.x *= iResolution.x/iResolution.y;
    vec2 mo = iMouse.xy/iResolution.xy;
		 

	// camera	
	vec3 ro = vec3( -0.5+3.2*cos(0.1*1.5 + 6.0*mo.x), 1.0 + 5.*(mo.y), 0.5 + 3.2*sin(0.1*1.5 + 6.0*mo.x) );
	vec3 ta = vec3( -0.5, 0.4, 1.0 );
	
	// camera tx
	vec3 cw = normalize( ta-ro );
	vec3 cp = vec3( 0.0, 1.0, 0.0 );
	vec3 cu = normalize( cross(cw,cp) );
	vec3 cv = normalize( cross(cu,cw) );
	vec3 rd = normalize( p.x*cu + p.y*cv + 2.5*cw );

	freqs[0] = texture( iChannel1, vec2( 0.01, 0.25 ) ).x;
	freqs[1] = texture( iChannel1, vec2( 0.07, 0.25 ) ).x;
	freqs[2] = texture( iChannel1, vec2( 0.15, 0.25 ) ).x;
	freqs[3] = texture( iChannel1, vec2( 0.30, 0.25 ) ).x;
	
	f0 = pow( clamp( freqs[0]*0.99, 0.0, 1.0 ), 5.0 );
	f1 = pow( clamp( freqs[1]*0.99, 0.0, 1.0 ), 5.0 )*1.5;
	f3 = pow( clamp( freqs[2]*0.99, 0.0, 1.0 ), 5.0 )*1.5;
	f2 = pow( clamp( freqs[3]*0.99, 0.0, 1.0 ), 5.0 );
	
	vec3 col = vec3(0.0);
    col = getColor( ro, rd, fragCoord );

    fragColor=vec4( col, 1.0 );
}