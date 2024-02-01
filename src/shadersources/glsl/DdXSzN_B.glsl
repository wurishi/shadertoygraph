void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = okhsl_to_linear_srgb(vec3(uv.x,uv.y,0.66));
    vec3 lab = linear_srgb_to_oklab(getPaletteMatchLAB(col));
    fragColor = vec4(lab, 1.0);
}