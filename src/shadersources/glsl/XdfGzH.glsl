// ====
//note: period of 2, [-1;1]=/\ 
float sawtooth( float t ) {
	return abs(mod(abs(t), 2.0)-1.0);
}

//note: from https://iquilezles.org/articles/smin
//      polynomial smooth min (k = 0.1);
float smin_cubic( float a, float b, float k )
{
    float h = max( k-abs(a-b), 0.0 )/k;
    return min( a, b ) - h*h*h*k*(1.0/6.0);
}


// Given a vec2 in [-1,+1], generate a texture coord in [0,+1]
vec2 barrelDistortion( vec2 p, vec2 amt )
{
    p = 2.0 * p - 1.0;

    /*
    const float maxBarrelPower = 5.0;
	//note: http://glsl.heroku.com/e#3290.7 , copied from Little Grasshopper
    float theta  = atan(p.y, p.x);
    vec2 radius = vec2( length(p) );
    radius = pow(radius, 1.0 + maxBarrelPower * amt);
    p.x = radius.x * cos(theta);
    p.y = radius.y * sin(theta);

	/*/
    // much faster version
    //const float maxBarrelPower = 5.0;
    //float radius = length(p);
    float maxBarrelPower = sqrt(5.0);
    float radius = dot(p,p); //faster but doesn't match above accurately
    
    radius = -smin_cubic(-radius,0.00, 1.0);
    
    p *= pow(vec2(radius), maxBarrelPower * amt);
	/* */

    return p * 0.5 + 0.5;
}

//note: from https://www.shadertoy.com/view/MlSXR3
vec2 brownConradyDistortion(vec2 uv, float dist)
{
    uv = uv * 2.0 - 1.0;
    // positive values of K1 give barrel distortion, negative give pincushion
    float barrelDistortion1 = 0.1 * dist; // K1 in text books
    float barrelDistortion2 = -0.025 * dist; // K2 in text books

    float r2 = dot(uv,uv);
    uv *= 1.0 + barrelDistortion1 * r2 + barrelDistortion2 * r2 * r2;
    //uv *= 1.0 + barrelDistortion1 * r2;
    
    // tangential distortion (due to off center lens elements)
    // is not modeled in this function, but if it was, the terms would go here
    return uv * 0.5 + 0.5;
}

float remap( float t, float a, float b )
{
    return (t-a)/(b-a);
}
vec2 remap( vec2 t, vec2 a, vec2 b )
{
    return vec2( remap( t.x, a.x, b.x ),
                 remap( t.y, a.y, b.y ) );
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
    float distpow = 5.0;
    if ( iMouse.z > 0.5 )
        distpow = (1.2-iMouse.x / iResolution.x) * 10.0;
    
	//note: domain distortion
	//const vec2 ctr = vec2(0.5,0.5);
	//vec2 ctrvec = ctr - uv;
	//float ctrdist = length( ctrvec );
	//ctrvec /= ctrdist;
	//uv += ctrvec * max(0.0, pow(ctrdist, distpow)-0.0025);
    
    //uv = barrelDistortion(uv, vec2(0.05) );
    
    uv = brownConradyDistortion( uv, distpow );
    vec2 minuv = brownConradyDistortion( vec2(0,0), distpow );
    vec2 maxuv = brownConradyDistortion( vec2(1,1), distpow );
    uv = remap( uv, minuv, maxuv );
	
	//note: lines
	vec2 div = 40.0 * vec2(1.0, iResolution.y / iResolution.x );
	float lines = 0.0;
	lines += smoothstep( 0.2, 0.0, sawtooth( uv.x*2.0*div.x ) );
	lines += smoothstep( 0.2, 0.0, sawtooth( uv.y*2.0*div.y ) );
	lines = clamp( lines, 0.0, 1.0 );
	
	vec3 outcol = vec3(0.0);
	outcol += texture( iChannel0, vec2(0,1)+vec2(1,-1)*uv ).rgb;
	outcol *= vec3(1.0-lines); //black
	//outcol += vec3(lines); //white

	//note: force black outside valid range	
	vec2 valid = step( vec2(0.0), uv ) * step( uv, vec2(1.0) );
	outcol *= valid.x*valid.y;
	
	fragColor = vec4(outcol,1.0);
}