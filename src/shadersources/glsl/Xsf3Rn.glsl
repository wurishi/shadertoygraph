// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

vec3 deform( in vec2 p, in float t )
{
    p += 0.5*sin( t*vec2(1.1,1.3)+vec2(0.0,0.5) );

	float a = atan( p.y, p.x );
    float r = length( p );
    
    float s = r * (1.0+0.5*cos(t*1.7));

    vec2 uv = 0.1*t + 0.05*p.yx + 0.05*vec2( cos(t+a*2.0),  
                                             sin(t+a*2.0))/s;

    return texture( iChannel0, 0.5*uv ).xyz;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 q = fragCoord/iResolution.xy;
    vec2 p = -1.0 + 2.0*q;
    
    vec3 col = vec3(0.0);
    for( int i=0; i<20; i++ )
    {
        float t = iTime + float(i)*0.007; 
        col += deform( p, t );
    }
    col /= 20.0;
    
    col = col.xzy;

	col *= 1.5*(0.5 + 0.5*pow( 16.0*q.x*q.y*(1.0-q.x)*(1.0-q.y), 0.25 ));
    fragColor = vec4( col, 1.0 );
}