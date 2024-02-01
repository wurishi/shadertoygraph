// Copyright Inigo Quilez, 2014 - https://iquilezles.org/
// I am the sole copyright owner of this Work.
// You cannot host, display, distribute or share this Work neither
// as it is or altered, here on Shadertoy or anywhere else, in any
// form including physical and digital. You cannot use this Work in any
// commercial or non-commercial product, website or project. You cannot
// sell this Work and you cannot mint an NFTs of it or train a neural
// network with it without permission. I share this Work for educational
// purposes, and you can link to it, through an URL, proper attribution
// and unmodified screenshot, as part of your educational material. If
// these conditions are too restrictive please contact me and we'll
// definitely work it out.

#define AA 2

// { 2d cell id, distance to border, distnace to center )
vec4 hexagon( vec2 p ) 
{
	vec2 q = vec2( p.x*2.0*0.5773503, p.y + p.x*0.5773503 );
	
	vec2 pi = floor(q);
	vec2 pf = fract(q);

	float v = mod(pi.x + pi.y, 3.0);

	float ca = step(1.0,v);
	float cb = step(2.0,v);
	vec2  ma = step(pf.xy,pf.yx);
	
    // distance to borders
	float e = dot( ma, 1.0-pf.yx + ca*(pf.x+pf.y-1.0) + cb*(pf.yx-2.0*pf.xy) );

	// distance to center	
	p = vec2( q.x + floor(0.5+p.y/1.5), 4.0*p.y/3.0 )*0.5 + 0.5;
	float f = length( (fract(p) - 0.5)*vec2(1.0,0.85) );		
	
	return vec4( pi + ca - cb*ma, e, f );
}

float hash1( vec2  p ) { float n = dot(p,vec2(127.1,311.7) ); return fract(sin(n)*43758.5453); }

float noise( in vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);
	f = f*f*(3.0-2.0*f);
	vec2 uv = (p.xy+vec2(37.0,17.0)*p.z) + f.xy;
	vec2 rg = textureLod( iChannel0, (uv+0.5)/256.0, 0.0 ).yx;
	return mix( rg.x, rg.y, f.z );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{
    vec3 tot = vec3(0.0);
    
    #if AA>1
    for( int mm=0; mm<AA; mm++ )
    for( int nn=0; nn<AA; nn++ )
    {
        vec2 off = vec2(mm,nn)/float(AA);
        vec2 uv = (fragCoord+off)/iResolution.xy;
        vec2 pos = (-iResolution.xy + 2.0*(fragCoord+off))/iResolution.y;
    #else    
    {
        vec2 uv = fragCoord/iResolution.xy;
        vec2 pos = (-iResolution.xy + 2.0*fragCoord)/iResolution.y;
    #endif

        // distort
        pos *= 1.2 + 0.15*length(pos);

        // gray
        vec4 h = hexagon(8.0*pos + 0.5*iTime);
        float n = noise( vec3(0.3*h.xy+iTime*0.1,iTime) );
        vec3 col = 0.15 + 0.15*hash1(h.xy+1.2)*vec3(1.0);
        col *= smoothstep( 0.10, 0.11, h.z );
        col *= smoothstep( 0.10, 0.11, h.w );
        col *= 1.0 + 0.15*sin(40.0*h.z);
        col *= 0.75 + 0.5*h.z*n;

        // shadow
        h = hexagon(6.0*(pos+0.1*vec2(-1.3,1.0)) + 0.6*iTime);
        col *= 1.0-0.8*smoothstep(0.45,0.451,noise( vec3(0.3*h.xy+iTime*0.1,0.5*iTime) ));

        // red
        h = hexagon(6.0*pos + 0.6*iTime);
        n = noise( vec3(0.3*h.xy+iTime*0.1,0.5*iTime) );
        vec3 colb = 0.9 + 0.8*sin( hash1(h.xy)*1.5 + 2.0 + vec3(0.1,0.9,1.1) );
        colb *= smoothstep( 0.10, 0.11, h.z );
        colb *= 1.0 + 0.15*sin(40.0*h.z);

        col = mix( col, colb, smoothstep(0.45,0.451,n) );
        
        col *= 2.5/(2.0+col);

        col *= pow( 16.0*uv.x*(1.0-uv.x)*uv.y*(1.0-uv.y), 0.1 );

        tot += col;
	}	
 	#if AA>1
    tot /= float(AA*AA);
    #endif
        
	fragColor = vec4( tot, 1.0 );
}