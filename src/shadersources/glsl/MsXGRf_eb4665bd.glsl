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

// You can buy a metal print of this shader here:
// https://www.redbubble.com/i/metal-print/Flames-by-InigoQuilez/39844894.0JXQP


#if HW_PERFORMANCE==0
//#define HIGH_QUALITY
#else
#define HIGH_QUALITY
#endif


float noise( in vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    
#ifndef HIGH_QUALITY
    vec2 uv = (p.xy+vec2(37.0,17.0)*p.z) + f.xy;
    vec2 rg = textureLod( iChannel0, (uv+ 0.5)/256.0, 0.0 ).yx;
    return mix( rg.x, rg.y, f.z );
#else
    ivec3 q = ivec3(p);
	ivec2 uv = q.xy + ivec2(37,17)*q.z;
	vec2 rg = mix(mix(texelFetch(iChannel0,(uv           )&255,0).yx,
				      texelFetch(iChannel0,(uv+ivec2(1,0))&255,0).yx,f.x),
				  mix(texelFetch(iChannel0,(uv+ivec2(0,1))&255,0).yx,
				      texelFetch(iChannel0,(uv+ivec2(1,1))&255,0).yx,f.x),f.y);
	return mix( rg.x, rg.y, f.z );
#endif    
}

vec4 map( in vec3 p )
{
    vec3 r = p; p.y += 0.6;
    // invert space
    p = -4.0*p/dot(p,p);
    // twist space
    float an = -1.0*sin(0.1*iTime + length(p.xz) + p.y);
    float co = cos(an);
    float si = sin(an);
    p.xz = mat2(co,-si,si,co)*p.xz;
    
    // distort
    p.xz += -1.0 + 2.0*noise( p*1.1 );
    // pattern
    float f;
    vec3 q = p*0.85                     - vec3(0.0,1.0,0.0)*iTime*0.12;
    f  = 0.50000*noise( q ); q = q*2.02 - vec3(0.0,1.0,0.0)*iTime*0.12;
    f += 0.25000*noise( q ); q = q*2.03 - vec3(0.0,1.0,0.0)*iTime*0.12;
    f += 0.12500*noise( q ); q = q*2.01 - vec3(0.0,1.0,0.0)*iTime*0.12;
    f += 0.06250*noise( q ); q = q*2.02 - vec3(0.0,1.0,0.0)*iTime*0.12;
    f += 0.04000*noise( q ); q = q*2.00 - vec3(0.0,1.0,0.0)*iTime*0.12;
    float den = clamp( (-r.y-0.6 + 4.0*f)*1.2, 0.0, 1.0 );
    vec3 col = 1.2*mix( vec3(1.0,0.8,0.6), 0.9*vec3(0.3,0.2,0.35), den ) ;
    col += 0.05*sin(0.05*q);
    col *= 1.0 - 0.8*smoothstep(0.6,1.0,sin(0.7*q.x)*sin(0.7*q.y)*sin(0.7*q.z))*vec3(0.6,1.0,0.8);
    col *= 1.0 + 1.0*smoothstep(0.5,1.0,1.0-length( (fract(q.xz*0.12)-0.5)/0.5 ))*vec3(1.0,0.9,0.8);
    col = mix( vec3(0.8,0.32,0.2), col, clamp( (r.y+0.1)/1.5, 0.0, 1.0 ) );
    return vec4( col, den );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // inputs
    vec2 q = fragCoord.xy / iResolution.xy;
    vec2 p = (-1.0 + 2.0*q) * vec2( iResolution.x/ iResolution.y, 1.0 );
    vec2 mo = iMouse.xy / iResolution.xy;
    if( iMouse.w<=0.00001 ) mo=vec2(0.0);
    
    //--------------------------------------
    // cameran    
    //--------------------------------------
    float an = -0.07*iTime + 3.0*mo.x;
    vec3 ro = 4.5*normalize(vec3(cos(an), 0.5, sin(an)));
    ro.y += 1.0;
    vec3 ta = vec3(0.0, 0.5, 0.0);
    float cr = -0.4*cos(0.02*iTime);
    
    // build rayn
    vec3 ww = normalize( ta - ro );
    vec3 uu = normalize( cross( vec3(sin(cr),cos(cr),0.0), ww ) );
    vec3 vv = normalize( cross(ww,uu) );
    vec3 rd = normalize( p.x*uu + p.y*vv + 2.5*ww );
    
    //--------------------------------------
    // raymarch
    //--------------------------------------
    vec4 sum = vec4( 0.0 );
    vec3 bg = vec3(0.4,0.5,0.5)*1.3;
    // dithering
    float t = 0.05*texture( iChannel0, fragCoord.xy/iChannelResolution[0].x ).x;
    for( int i=0; i<128; i++ )
    {
        if( sum.a > 0.99 ) break;
        vec3 pos = ro + t*rd;
        vec4 col = map( pos );
        col.a *= 0.5;
        col.rgb = mix( bg, col.rgb, exp(-0.002*t*t*t) ) * col.a;
        sum = sum + col*(1.0 - sum.a);
        t += 0.05;
    }
    
    vec3 col = clamp( mix( bg, sum.xyz/(0.001+sum.w), sum.w ), 0.0, 1.0 );
    
    //--------------------------------------
    // contrast + vignetting
    //--------------------------------------
    col = col*col*(3.0-2.0*col)*1.4 - 0.4;
    col *= 0.25 + 0.75*pow( 16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y), 0.1 );
    fragColor = vec4( col, 1.0 );
}