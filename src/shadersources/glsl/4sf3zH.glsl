#ifdef GL_ES
precision highp float;
#endif
#define EFFECT0 // 0..2

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float scale  = cos(iTime*0.1) * 0.01 + 0.011;
    vec2 offset  = iResolution.xy*0.5
		           + vec2(sin(iTime*0.3), cos(iTime*0.6))*100.0;


    vec2 pos = (fragCoord.xy-offset) / iResolution.xy;
    float aspect = iResolution.x /iResolution.y;
    pos.x = pos.x*aspect;

    float dist = length(pos);
    float dist2 = (dist*dist)/scale;

#ifdef EFFECT0
    // 
    vec4 color = vec4(abs( tan(dist/scale*0.045) * sin(dist*0.01/scale) * 0.1 ),
                      abs( tan(dist/scale*0.044) * 0.1),
                      abs( cos(dist2*0.036*iTime) * cos(dist2*0.0067*iTime)),
                      1.0);
#endif

#ifdef EFFECT1
    // space eye

    vec4 color = vec4( abs( sin(pos.y*dist2*0.1/scale)),
                       abs( sin(pos.y*dist2*0.3/scale)  * sin(dist*1.1/scale)),
                       abs( sin(pos.y*dist2*0.2/scale)) * cos(dist*0.05/scale),
                       1.0);
#endif
   
#ifdef EFFECT2
    
    float grey = abs( cos(dist2*1.66) * cos(dist2*1.33) * cos(dist2*1.33));
    vec4 color = vec4(grey, grey, grey, 1.0);

#endif


    fragColor = color;
}