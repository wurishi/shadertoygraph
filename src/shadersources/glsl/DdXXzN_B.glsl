// from Eikonal FIM at http://shadertoy.com/view/7dGSz3
// RNG

uint wang_hash(inout uint seed)
{
    seed = uint(seed ^ uint(61)) ^ uint(seed >> uint(16));
    seed *= uint(9);
    seed = seed ^ (seed >> 4);
    seed *= uint(0x27d4eb2d);
    seed = seed ^ (seed >> 15);
    return seed;
}

float RandomFloat01(inout uint state)
{
    return float(wang_hash(state)) / 4294967296.0;
}

vec4 sampleRandom(sampler2D tex, vec2 fragCoord, inout uint rngState)
{
    fragCoord /= vec2(textureSize(tex, 0));
    fragCoord += vec2
    (
        RandomFloat01(rngState),
        RandomFloat01(rngState)
    );
    
    return textureLod(tex, fragCoord, 0.0) - textureLod(tex, fragCoord, 20.0);
}

void mainImage(out vec4 o, vec2 p)
{
    uint rngState = uint
    (
        uint(iFrame) * uint(1973) 
    ) | uint(1);
    
    //o = vec4(sampleRandom(iChannel3, p, rngState).g);
    //return;

 #define decode(x) (((x) - bias) * e)
 #define T(x) decode(textureLod(iChannel2, (x)/r, 0.).r - textureLod(iChannel2, (x)/r, 20.).r + 0.5)
    vec2 r = iResolution.xy;
    const float bias = .5, // meh
        e = exp2(8.5); // controls steepness
    o = texelFetch(iChannel2, ivec2(0), 0);
    
    float time = iTime * 4.0 + 1.5;
    float temperature = time*time*10.1+1.0;
    float scaleTemperature = sqrt(time);
    
    float d = T(p);
    // handle resolution change, for full screen support
    if (iFrame < 1 || !(length(o.yz-r) < .5) || iChannelResolution[3].x < 1.) {
        d = sampleRandom(iChannel3, p * scaleTemperature, rngState).g;
    } else {
        float od = d/e + bias; // undoes some stuff in T FIXME
        // compute local gradient
        vec2 g = vec2(T(p + vec2(1,0))
                    - T(p - vec2(1,0))
                    , T(p + vec2(0,1))
                    - T(p - vec2(0,1))) * .5;
        float dsgn = sign(d);
        dsgn *= 50.0 / (temperature); // slow melt rate
        const float stretch = 1.001;
        vec2 q = p - dsgn * inversesqrt(dot(g, g)) * g;
        d = T(q)
            + dsgn * stretch;
        d /= e;
        d += bias;
        d = mix(od, d, .8);
        float noise = sampleRandom(iChannel3, p*sqrt(time), rngState).g;
              
        d += noise*2.0 / (temperature);
       d = clamp(d, 0., 1.);
    }
    //d = sampleRandom(iChannel3, p * (iTime*iTime+1.0), rngState).g/ (iTime*iTime+1.0);
    o = vec4(d,d,d,1);
    if (ivec2(p) == ivec2(0))
        o.yz = r;
}
