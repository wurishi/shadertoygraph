void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iChannelResolution[1].xy;

    vec3 image_hsl = linear_srgb_to_okhsl(SRGBtoRGB(texture(iChannel1,uv).rgb));
    
    image_hsl = clamp(image_hsl,0.0,1.0);
    
    
    
    
    vec3 lab = texture(iChannel0,image_hsl.xy).rgb;
    vec3 hsl = oklab_to_okhsl(lab);
    
    hsl.z = image_hsl.z;
    
    hsl = clamp(hsl,0.0,1.0);
    
    vec3 color = RGBtoSRGB(okhsl_to_linear_srgb(hsl));
    
    fragColor = vec4(color,1.0);
}
