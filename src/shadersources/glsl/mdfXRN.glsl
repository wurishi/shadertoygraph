float luminance(vec3 v)
{
    return dot(v, vec3(0.2126f, 0.7152f, 0.0722f));
}

vec3 change_luminance(vec3 c_in, float l_out)
{
    float l_in = luminance(c_in);
    return c_in * (l_out / l_in);
}

vec3 reinhard_extended_luminance(vec3 v, float max_white_l)
{
    float l_old = luminance(v);
    float numerator = l_old * (1.0f + (l_old / (max_white_l * max_white_l)));
    float l_new = numerator / (1.0f + l_old);
    return change_luminance(v, l_new);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 self = texture(iChannel1, uv).xyz;

    // Output to screen
    if (fragCoord.x <= iMouse.x) {
        vec2 nudge = 1.0/iResolution.xy;
        vec3 blur = vec3(0.0);

        for (int y = -COUNT; y <= COUNT; ++y) {
            blur += texture(iChannel0, uv + nudge * vec2(ivec2(0, y))).xyz;
        }

        blur /= float(COUNT * 2 + 1);
    
        float greyscale = pow(dot(self, vec3(0.4, 0.5, 0.1)), 2.2);
        vec3 adj = (self - blur) * SCALE * greyscale + self;
        
        fragColor = vec4(reinhard_extended_luminance(adj, 0.9),1.0);
    } else {
        fragColor = vec4(self,1.0);
    }
}