// Created by inigo quilez - iq/2013

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = 1.1 * (2.0*fragCoord-iResolution.xy)/min(iResolution.y,iResolution.x);

    float a = dot(p,p);
    float b = abs(p.y)-a;
    float c = (b>0.0) ? p.y : p.x;
    float d = (a-1.0)*(b-0.23)*c;
    
    float r = (a>1.0) ? 0.6 : 
              (d>0.0) ? 1.0 : 
                        0.0;

	fragColor = vec4( r, r, r, 1.0 );
}