// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = (2.0*fragCoord-iResolution.xy) / iResolution.y;

    vec2 cst = vec2(cos(iTime), sin(iTime));
    mat2 tra = mat2(cst.x,-cst.y,cst.y,cst.x)*(1.0 + 0.5*cst.x);

    vec3 col = texture( iChannel0, 0.5 + 0.5*tra*p ).xyz;
    fragColor = vec4( col, 1.0 );
}