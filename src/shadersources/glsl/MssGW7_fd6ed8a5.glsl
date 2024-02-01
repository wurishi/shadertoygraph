// noise & fbm by iq

float hash( float n )
{
    return fract( sin(n)* 43758.5453123 );
}

float noise1( float x )
{
    float p = floor(x);
    float f = fract(x);

    f = f*f*(3.0-2.0*f);

    return mix( hash(p+0.0), hash(p+1.0), f );
}

float fbm( float p )
{
    float f = 0.0;

    f += 0.5000*noise1( p ); p = p*2.02;
    f += 0.2500*noise1( p ); p = p*2.03;
    f += 0.1250*noise1( p ); p = p*2.01;
    f += 0.0625*noise1( p );

    return f/0.9375;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	float c = dot( vec3( fbm( uv.y * 5.134 + iTime * 2.013 ),
			             fbm( uv.y * 15.002 + iTime * 3.591 ),
						 fbm( uv.y * 25.922 + iTime * 4.277 ) ),
				   vec3( .85, .35, .17 ) );

	fragColor = vec4( c, c, c, 1.);
}