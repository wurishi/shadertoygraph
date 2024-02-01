#define SCALE 6.0
#define R iResolution.xy
#define M iMouse
#define PI 3.14159265358979

// gradient map ( equation, time, hardness, shadow, reciprocals )
float gm(float eq, float t, float h, float s, bool i)
{
    float sg = min(abs(eq), 1.0/abs(eq)); // smooth gradient
    float og = abs(sin(eq*PI-t)); // oscillating gradient
    if (i) og = min(og, abs(sin(PI/eq+t))); // reciprocals
    return pow(1.0-og, h)*pow(sg, s);
}

void mainImage(out vec4 RGBA, in vec2 XY)
{
    float t = iTime/2.0;
    float z = (M.z > 0.0) ? SCALE/2.0/(M.y/R.y): SCALE; // zoom
    float h = 5.0; // hardness
    float s = 0.25; // shadow
    bool rc = false; // reciprocals
    vec3 bg = vec3(0); // black background
    
    float aa = 3.0; // anti-aliasing
    for (float j = 0.0; j < aa; j++)
    for (float k = 0.0; k < aa; k++)
    {
        vec3 c = vec3(0);
        vec2 o = vec2(j, k)/aa;
        vec2 sc = (XY-0.5*R+o)/R.y*z; // screen coords
        float x2 = sc.x*sc.x;
        float y2 = sc.y*sc.y;

        // square root grids
        c += gm(x2, t, h, s, rc); // x
        c += gm(y2, 0.0, h, s, rc); // y
        c += gm(x2+y2, t, h, s, rc); // addition
        c += gm(x2-y2, t, h, s, rc); // subtraction
        c += gm(x2*y2, t, h, s, rc); // multiplication
        c += gm(x2/y2, t, h, s, rc); // division
        
        bg += c;
    }
    bg /= aa*aa;
    
    bg *= sqrt(bg)*0.5; // brightness & contrast
    RGBA = vec4(bg, 1.0);
}