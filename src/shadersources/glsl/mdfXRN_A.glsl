void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 nudge = 1.0/iResolution.xy;
    vec2 uv = fragCoord/iResolution.xy;

    vec3 blur = vec3(0.0);
    
    for (int x = -COUNT; x <= COUNT; ++x) {
        blur += texture(iChannel0, uv + nudge * vec2(ivec2(x, 0))).xyz;
    }
    
    blur /= float(COUNT * 2 + 1);

    // Output to screen
    fragColor = vec4(blur,1.0);
}