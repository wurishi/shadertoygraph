// Copyright Inigo Quilez, 2016 - https://iquilezles.org/
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

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec4 data = texelFetch( iChannel0, ivec2(fragCoord), 0 );
    vec3 col = data.xyz/data.w;

    // tonemap
    col = col*1.4/(1.0+col);
    
    // gamma
    col = pow( col, vec3(0.4545) );
    
    // vignetting
	vec2 uv = fragCoord / iResolution.xy;
    col *= 0.5 + 0.5*pow( 16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y), 0.1 );
    
    fragColor = vec4( col, 1.0 );
}