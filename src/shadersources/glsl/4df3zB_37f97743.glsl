void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord.xy / iResolution.xy + iMouse.xy/ iResolution.xy;

    vec2 cc = 1.1*vec2( 0.5*tanh(0.1*iTime) - 0.25*cos(0.02*iTime), 
	                    0.5+sin(0.1*iTime) - 0.25*tan(0.002+iTime) );

	vec4 dmin = vec4(100.0);
    vec2 z = (-1.0 + 1.0/p)*vec2(1.6,1.3);
    for( int i=0; i<64; i++ )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
		z += 0.15+sin(float(i));
		dmin=min(dmin, vec4(abs(0.0+z.y - 2.2*sin(z.x)), 
							abs(1.0+z.x + 23.25*sin(z.y)), 
							dot(z,z),
						    length( fract(z)-0.2) ) );
    }
    
    vec3 color = vec3( dmin.w );
	color = mix( color, vec3(2.80,0.40,0.20),     min(1.0,pow(dmin.x*0.25,0.20)) );
    color = mix( color, vec3(0.12,0.70,0.60),     min(1.0,pow(dmin.y*0.50,0.50)) );
	color = mix( color, vec3(0.90,0.40,0.20), 1.0-min(1.0,pow(dmin.z*1.00,0.15) ));

	color = 1.25*color+color+color*color;
	
	color *= 0.5555 + 0.5*pow(9.0*p.x*(1.0-p.y)*p.y*(1.0-p.y),0.15);

	fragColor = vec4(color,1.0)*0.33333333;
}


// mod of mod from original maker 
// https://www.shadertoy.com/view/MsXGzr