// Copyright Inigo Quilez, 2013 - https://iquilezles.org/
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

// Other "Iterations" shaders:
//
// "trigonometric"   : https://www.shadertoy.com/view/Mdl3RH
// "trigonometric 2" : https://www.shadertoy.com/view/Wss3zB
// "circles"         : https://www.shadertoy.com/view/MdVGWR
// "coral"           : https://www.shadertoy.com/view/4sXGDN
// "guts"            : https://www.shadertoy.com/view/MssGW4
// "inversion"       : https://www.shadertoy.com/view/XdXGDS
// "inversion 2"     : https://www.shadertoy.com/view/4t3SzN
// "shiny"           : https://www.shadertoy.com/view/MslXz8
// "worms"           : https://www.shadertoy.com/view/ldl3W4
// "stripes"         : https://www.shadertoy.com/view/wlsfRn


// define the following for a version without texture lookups
//#define PROCEDURAL

float hash( float n )
{
    return fract(sin(n)*43758.5453);
}

float noise( in vec2 x )
{
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0;
    return mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
               mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y);
}

const mat2 ma = mat2( 0.8, -0.6, 0.6, 0.8 );

vec2 map( vec2 p )
{
	float a  = 0.7*noise(p)*6.2831*6.0; p = ma*p*3.0;
	      a += 0.3*noise(p)*6.2831*6.0;
	a += 0.2*iTime;
	return vec2( cos(a), sin(a) );
}

vec3 texturef( in vec2 p )
{
    #ifndef PROCEDURAL
    return texture( iChannel0, p ).xyz;
    #else
	vec2 q = p;
	p *= 32.0;
    
	float f = 0.0;
    f += 0.500*noise( p ); p = ma*p*2.02;
    f += 0.250*noise( p ); p = ma*p*2.03;
    f += 0.125*noise( p ); p = ma*p*2.01;
	f /= 0.875;
	
	vec3 col = 0.53 + 0.47*sin( f*4.5 + vec3(0.0,0.65,1.1) + 0.6 );
    return col*0.7*clamp( 1.65*noise( 16.0*q.yx ), 0.0, 1.0 );
    #endif
}

vec2 iterate( in vec2 uv, out vec3 oCol )
{
    vec2 or = uv;
	
	float acc = 0.0;
	vec3  col = vec3(0.0);
	for( int i=0; i<64; i++ )
	{
		vec2 dir = map( uv );
		
		float h = float(i)/64.0;
		float w = 1.0-h;
		vec3 ttt = w*texturef(0.5*uv );
		ttt *= mix( 0.8*vec3(0.4,0.55,0.65), vec3(1.0,0.9,0.8), 0.5 + 0.5*dot( dir, -vec2(0.707) ) );
		
		col += w*ttt;
		acc += w;
		
		uv += 0.015*dir;
	}
	oCol = col/acc;

    return uv;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // --- iterate 3 times so that we can compute gradients
    
    vec2 p = fragCoord / iResolution.xy;
    vec2 orc = (2.0* fragCoord           -iResolution.xy)/iResolution.y;
    vec2 orx = (2.0*(fragCoord+vec2(1,0))-iResolution.xy)/iResolution.y;
    vec2 ory = (2.0*(fragCoord+vec2(0,1))-iResolution.xy)/iResolution.y;
    
    vec3 colc, colx, coly;
    vec2 uvc = iterate( orc, colc );
    vec2 uvx = iterate( orx, colx );
    vec2 uvy = iterate( ory, coly );

    float llc = length(uvc-orc);
    float llx = length(uvx-orx);
    float lly = length(uvy-ory);
    vec3 nor = normalize( vec3(llx-llc, 4.0/iResolution.x, lly-llc ) );

	float tec = texturef(4.0*uvc + 4.0*p).x;
    float tex = texturef(4.0*uvx + 4.0*p).x;
    float tey = texturef(4.0*uvy + 4.0*p).x;
    vec3 bnor = normalize( vec3(tex-tec, 400.0/iResolution.x, tey-tec) );
	nor = normalize( nor + 0.5*normalize(bnor) );
    
    // --- color ---

	vec2 di = map( uvc );

    vec3 col = colx;
	col *= 0.8 + 0.2*dot( di, -vec2(0.707) );
	col *= 2.5;
	col += vec3(1.0,0.5,0.2)*0.15*dot(nor,normalize(vec3(0.8,0.2,-0.8)) );
	col += 0.12*pow(nor.y,16.0);
	col += llc*vec3(1.0,0.8,0.6)*col*0.5*(1.0-pow(nor.y,1.0));
	col *= 0.5 + llc;
	col *= 0.2 + 0.8*pow( 4.0*p.x*(1.0-p.x), 0.25 );

	fragColor = vec4( col, 1.0 );
}
