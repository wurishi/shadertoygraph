float hash( float n )
{
	return fract( sin(n) * 43812.175489);
}


float noise( vec2 p ) 
{
	vec2 pi = floor( p );
	vec2 pf = fract( p );
	
	
	float n = pi.x + 59.0 * pi.y;
	
	pf = pf * pf * (3.0 - 2.0 * pf);
	
	return mix( 
		mix( hash( n ), hash( n + 1.0 ), pf.x ),
		mix( hash( n + 59.0 ), hash( n + 1.0 + 59.0 ), pf.x ),
		pf.y );
		
		
}

float noise( vec3 p ) 
{
	vec3 pi = floor( p );
	vec3 pf = fract( p );

	
	float n = pi.x + 59.0 * pi.y + 256.0 * pi.z;

	pf.x = pf.x * pf.x * (3.0 - 2.0 * pf.x);
	pf.y = pf.y * pf.y * (3.0 - 2.0 * pf.y);
	pf.z = sin( pf.z );

	float v1 = 	
		mix(
			mix( hash( n ), hash( n + 1.0 ), pf.x ),
			mix( hash( n + 59.0 ), hash( n + 1.0 + 59.0 ), pf.x ),
			pf.y );
	
	float v2 = 	
		mix(
		mix( hash( n + 256.0 ), hash( n + 1.0 + 256.0 ), pf.x ),
			mix( hash( n + 59.0 + 256.0 ), hash( n + 1.0 + 59.0 + 256.0 ), pf.x ),
			pf.y );

	return mix( v1, v2, pf.z );
}



void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv -= 0.5;

	float time = iTime / 30.0;
	time = 0.5 + 0.5 * sin( time * 6.238 );
	time = texture( iChannel0, vec2(0.5,0.5) ).x; 
	
	if( time < 0.2 )
	{
		// scene 0
		// uv *= 1.0;
	}
	else if( time < 0.4 )
	{
		// scene 1
		
		uv.x += 100.55;
		uv *= 0.00005;
	}
	else if( time < 0.6 )
	{
		// scene 2
		uv *= 0.00045;
	}
	else if( time < 0.8 ) 
	{
		// scene 3
		uv *= 500000.0;
	}
	else if( time < 1.0 ) 
	{
		// scene 3
		uv *= 0.000045;
	}
	
	
	float fft = texture( iChannel0, vec2(uv.x,0.25) ).x; 
	float ftf = texture( iChannel0, vec2(uv.x,0.15) ).x; 
	float fty = texture( iChannel0, vec2(uv.x,0.35) ).x; 
	uv *= 200.0 * sin( log( fft ) * 10.0 );
	
	if( sin( fty ) < 0.5 )
		uv.x += sin( fty ) * sin( cos( iTime ) + uv.y * 40005.0 ) ;
	
	// mat2 m = mat2( cos( iTime ), -sin( iTime ), sin( iTime ), cos( iTime ) );
	// uv = uv * m;
	uv *= sin( iTime * 179.0 );
	
	vec3 p;
	p.x = uv.x;
	p.y = uv.y;
	p.z = sin( 0.0 * iTime * ftf );
	
	float no = noise(p);

	vec3 col = vec3( 
		hash( no * 6.238  * cos( iTime ) ), 
		hash( no * 6.2384 + 0.4 * cos( iTime * 2.25 ) ), 
		hash( no * 6.2384 + 0.8 * cos( iTime * 0.8468 ) ) );
	
	
	
	float b = dot( uv, uv );
	b *= 10000.0;
	b = b * b;
	col.y *= b;
	
	fragColor = vec4(col,1.0);
}
	   