/*
float nrand( vec2 n ) {	return fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453); }

vec2 rot2d( vec2 p, float a ) {
	vec2 sc = vec2(sin(a),cos(a));
	return vec2( dot( p, vec2(sc.y, -sc.x) ), dot( p, sc.xy ) );
}
*/

vec4 basis_from_angle( float a )
{
    vec2 sc = vec2(sin(a),cos(a));

    vec4 ret;
    ret.xy = vec2(  sc.y, sc.x ); //p = vec2(1,0);
    ret.zw = vec2( -sc.x, sc.y ); //p = vec2(0,1);
    
    return ret;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y = 1.0-uv.y;
   
    float max_siz;
    if ( iMouse.z > 0.5 )
		max_siz = 32.0 * (1.0-iMouse.x / iResolution.x); // * (0.5+0.5*sin(iTime));
    else
        max_siz = 32.0 * (0.5+0.5*sin(2.0*uv.x + iTime));
        
    //fragColor = vec4( vec3(max_siz), 1.0 ); return;
	
    //note: for samples-positions see
    //      https://github.com/GPUOpen-Effects/ShadowFX/blob/master/amd_shadowfx/src/Shaders/
    const int NUM_TAPS = 18;
    const vec2 fTaps_Poisson[NUM_TAPS]
        = vec2[NUM_TAPS]( vec2(-0.220147, 0.976896),
                          vec2(-0.735514, 0.693436),
                          vec2(-0.200476, 0.310353),
                          vec2( 0.180822, 0.454146),
                          vec2( 0.292754, 0.937414),
                          vec2( 0.564255, 0.207879),
                          vec2( 0.178031, 0.024583),
                          vec2( 0.613912,-0.205936),
                          vec2(-0.385540,-0.070092),
                          vec2( 0.962838, 0.378319),
                          vec2(-0.886362, 0.032122),
                          vec2(-0.466531,-0.741458),
                          vec2( 0.006773,-0.574796),
                          vec2(-0.739828,-0.410584),
                          vec2( 0.590785,-0.697557),
                          vec2(-0.081436,-0.963262),
                          vec2( 1.000000,-0.100160),
                          vec2( 0.622430, 0.680868) );

    if ( uv.y > 0.5 )
    {
        fragColor = texture( iChannel0, uv, log2(max_siz) );
    }
    else
    {
        vec4 sum = vec4(0);
        
        //float rnd = 6.28 * nrand( uv + fract(iTime) );
        //
        float bn = texelFetch( iChannel3, (ivec2(fragCoord.xy)+ivec2(vec2(81,90)*7.0*iTime))%textureSize(iChannel3,0).xy, 0 ).r;
        //fragColor = vec4( vec3(bn), 1.0 ); return;
        float rnd = 6.28*bn;

        vec4 basis = basis_from_angle( rnd );

        for (int i=0; i < NUM_TAPS; i++)
        {
            vec2 ofs = fTaps_Poisson[i];
            ofs = vec2( dot(ofs,basis.xz),
                        dot(ofs,basis.yw) );
            
            vec2 texcoord = uv + max_siz * ofs / iResolution.xy;
            sum += texture(iChannel0, texcoord, -10.0);
        }

        fragColor = sum / float(NUM_TAPS);
    }    
}
