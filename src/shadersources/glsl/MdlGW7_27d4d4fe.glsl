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

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec4 data = texture( iChannel0, uv );

    vec3 col = vec3(0.0);
    if( data.w < 0.0 )
    {
        col = texture( iChannel0, uv ).xyz;
    }
    else
    {
        // decompress velocity vector
        float ss = mod(data.w,256.0)/255.0;
        float st = floor(data.w/256.0)/255.0;

        // motion blur (linear blur across velocity vectors
        vec2 dir = (-1.0 + 2.0*vec2( ss, st ))*0.25;
        col = vec3(0.0);
        for( int i=0; i<32; i++ )
        {
            float h = float(i)/31.0;
            vec2 pos = uv + dir*h;
            col += texture( iChannel0, pos ).xyz;
        }
        col /= 32.0;
    }
    
    // vignetting	
	col *= 0.5 + 0.5*pow( 16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y), 0.1 );

    fragColor = vec4( col, 1.0 );
}