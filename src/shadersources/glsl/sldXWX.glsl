// using heavy postprocessing to hide rendering imperfections
// is an old gamedev trick, too, define to see what's going on
//#define NO_POST_PROCESSING

const int num_bloom_samples = 132;
const float bloom_r = 0.01;
const float bloom_threshold = 0.9;
const float bloom_pow = 64.0;

//----------------------------------------------------------------------
const float PI = 3.141592; // close enough
const float TWO_PI = 2.*PI;

// texnoise
vec2 tnoise2d_2f(vec2 v, float m) {
    return texture(iChannel1, v + vec2(m*7.7)).xy;
}

// iq
float seed;	//seed initialized in main
float rnd() { return fract(sin(seed++)*43758.5453123); } // [0,1]
float rnd_signed() { return 2.*rnd() - 1.; } // [-1,1]

// gaussian filter, "bell curve/surface"
float gaussian(in vec2 v, float m) {
    return (1.0 / (TWO_PI*m*m)) * exp(-(v.x*v.x + v.y*v.y) / (2.0*m*m));
}


//----------------------------------------------------------------------
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 color = texture(iChannel0, fragCoord / iResolution.xy).rgb;
#ifdef NO_POST_PROCESSING
    fragColor = vec4(color, 1.0f);
#else
    vec2 uv = fragCoord / iResolution.xy; // [0,1], no aspect
    seed = iTime + uv.x*1234.5 + uv.y*6543.2; // TODO
    
    // LDR bloom with noise.. bring the noise! :D
    vec3 bloom = vec3(0);
    for(int n=0; n < num_bloom_samples; ++n) {
        vec2 ran = tnoise2d_2f(uv, iTime);
        float a = ran.x * TWO_PI; //rnd() * TWO_PI;
        float r = ran.y * bloom_r; //rnd() * bloom_r;
        vec2 v = vec2(cos(a)*r, sin(a)*r);
        float w = gaussian(v, 0.01);
        vec3 s = texture(iChannel0, uv + v).rgb; // note: iChannel0 wrap clamped
        s = clamp(s - vec3(bloom_threshold), 0.0, 1.0) / (1.0 - bloom_threshold); // [0,1] 
        s = pow(s, vec3(bloom_pow));
        bloom += w*s;
    }
    bloom /= float(num_bloom_samples);
    
    // DEBUG: show out-of-color-ranges problems..
    //if( c.r < 0.0 || c.g < 0.0 || c.b < 0.0 ) c = vec3(1,0,0);
    //if( c.r > 1.0 || c.g > 1.0 || c.b > 1.0 ) c = vec3(1,0,1);

    // crossfade into different post-processing..
    vec3 c = bloom;
    float t = fract(iTime/20.0);
    //t = 0.0; // DEBUG
    c = (t < 0.5) ? 
            mix(c, color, smoothstep(0.3, 0.5, t)):
            mix(color, c, smoothstep(0.8, 1.0, t));
    
    fragColor = vec4(c, 1.0);
#endif
}