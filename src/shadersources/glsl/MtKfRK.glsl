
#define Hash(x) fract(sin(x) * 34214.0)


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    float sp = Hash(floor(uv.x * 64.));
    uv.y += sp * iTime;
    float x_s = fract(uv.x * 64.);
    float y_s = fract(uv.y * 18.);
 
    float g = Hash(floor(uv.x * 410.) + Hash(floor(uv.y * 140.)));
    
    g = smoothstep(abs(g - 0.5), 0.2, 0.5);
    g *= step(x_s, 0.6) * step(y_s, 0.8) * step(Hash(floor(uv.y * 18.)) + Hash(floor(uv.x * 64.)), 1.0);
    
    g *= (1. - sp * 0.5);
    
    fragColor = vec4(0. ,g , 0. , 1.0);
}