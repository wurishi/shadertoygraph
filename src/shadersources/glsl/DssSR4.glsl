void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    uv -= 0.5;
    uv.x *= iResolution.x / iResolution.y;
    uv.x = abs(uv.x);
    uv.y = abs(uv.y);
    float d = uv.x + uv.y * uv.y + tan(iTime * 2.);
    d *= uv.x*uv.x+uv.y*uv.y;

    float blur = 0.2;
    float start = 0.1;
    float end = 0.5;
    
    if(d > start && d < end) {
        if(d < (end - start) / 2.) {
            d = smoothstep(start,start + blur,d);
        } else {
            d = smoothstep(end,end - blur,d);
        }
      
    } else {
        d = 0.;
     }

    // Output to screen
    fragColor = vec4(vec3(d),1.0);
}