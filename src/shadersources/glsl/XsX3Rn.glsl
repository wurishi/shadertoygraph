// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = -1.0+2.0*fragCoord/iResolution.y;
    
    float an = iTime*0.1;
    
    p = mat2(cos(an),-sin(an),sin(an),cos(an)) * p;
     
    vec2 uv = vec2(p.x,1.0)/abs(p.y) + iTime;
	
	fragColor = vec4( texture(iChannel0, 0.2*uv).xyz*abs(p.y)*0.8, 1.0);
}