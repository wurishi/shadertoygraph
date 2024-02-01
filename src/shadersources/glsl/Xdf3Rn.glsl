// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = (-iResolution.xy + 2.0*fragCoord)/iResolution.x;

    float r2 = dot(p,p);
    float r = sqrt(r2);
    
	#if 1
        // fancy
	    float a = atan(p.y,p.x);
        a += sin(2.0*r) - 3.0*cos(2.0+0.1*iTime);
        vec2 uv = vec2(cos(a),sin(a))/r;
    #else
        // traditional
        vec2 uv = p/r2;	
    #endif	

    // animate	
	uv += 10.0*cos( vec2(0.6,0.3) + vec2(0.1,0.13)*iTime );

	vec3 col = r * texture( iChannel0,uv*.25).xyz;
    
    fragColor = vec4( col, 1.0 );
}