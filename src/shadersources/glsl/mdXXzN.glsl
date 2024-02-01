#define PI 3.14159265358979323
#define hue(v) ( .6 + .6 * cos( 2.*PI*(v) + vec3(0,-2.*PI/3.,2.*PI/3.)))
#define ZOOM 250.

#define cmul(z1, z2) (mat2(z1, -z1.y, z1.x)*z2)
#define cdiv(z1, z2) (z1*mat2(z2, -z2.y, z2.x)/dot(z2, z2))



vec2 clog(vec2 z)
{
    vec2 w;
    
    w.x = 0.5*log(z.x*z.x + z.y*z.y);
    w.y = atan(z.y, z.x);
    
    return w;
}

vec3 hrgb(vec2 w)
{
    vec3 c, cc;
    float mm;
    float p;
    
    float m = length(w);
    float a = (PI + atan(w.y, -w.x))/(2.0*PI);
    
    m = log(1. + 100.*m);
    
    //cc = 0.;
    //cc.r =  0.5 - 0.5*sin(2.0*PI*a - PI/2.0 + a*m*100.);
   //cc.g = (0.5 + 0.5*sin(2.0*PI*a*1.5 - PI/2.0 + a*m*100.));// * float(a < 0.66);
    //cc.b = (0.5 + 0.5*sin(2.0*PI*a*1.5 + PI/2.0 + a*m*100.));// * float(a > 0.33);
    
    cc.r = 0.5 - 0.5*sin(2.0*PI*a - PI/2.0 + m*1.4 + 2.*iTime);
    cc.g = 0.5 - 0.5*sin(2.0*PI*a - PI/2.0 + m*1.4 + 2.*iTime);
    cc.b = 0.;
    
    
    //cc -= 0.1*m;
    //c = 0.5*(hue(a) + cc);
    c = cc;
    
    //mm = fract(m);
    //p = fract(mod(a, 1.0/16.0));
     
    //c -= 0.15*mm + 1.5*p;
    
    //if (/*length(w) + .05 > 1. &&*/
    //    (fract(w.x) < .05 || fract(-w.x) < .05 ||
    //     fract(w.y) < .05 || fract(-w.y) < .05)) c -= 0.5;
    
    return c;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 z, w, w1, w2, w3, w4;
    
    z = fragCoord - iResolution.xy/2.;
    
    
    if (iMouse.xy != vec2(0., 0.)) //to center at origin
        z -= iMouse.xy - iResolution.xy/2.;
    
    
    z /= ZOOM; //zoom

    //w = clog(z);
    w = cdiv(vec2(1.0, 0.), z);
    w =cdiv(w, z);
    w =cdiv(w, z);
    w =cdiv(w, z);
    w =cdiv(w, z);
    w =cdiv(w, z);

    
    
    
    
    w = cdiv(w, (z-0.5*vec2(1.,0.)));
     w = cdiv(w, (z-0.5*vec2(1.,0.)));
     w = cdiv(w, (z-0.5*vec2(1.,0.)));
     w = cdiv(w, (z-0.5*vec2(1.,0.)));
     
    
    w = cdiv(w, (z-0.5*vec2(2.,0.)));
    
    w = cdiv(w, (z-0.5*vec2(-1.,0.)));
    w = cdiv(w, (z-0.5*vec2(-1.,0.)));
    w = cdiv(w, (z-0.5*vec2(-1.,0.)));
    w = cdiv(w, (z-0.5*vec2(-1.,0.)));
    

    
    
    w = cdiv(w, (z-0.5*vec2(-2.,0.)));

    
        
    
    //w = cdiv(w, (z-vec2(1.,0.)));
    

    
   //w = z;            
    
    fragColor = vec4(hrgb(w), 1.0);
    

/*
    w1 = clog( z + vec2(-.25,-.25)/ZOOM );
    w2 = clog( z + vec2(-.25, .25)/ZOOM );
    w3 = clog( z + vec2( .25,-.25)/ZOOM );
    w4 = clog( z + vec2( .25, .25)/ZOOM );
    
    
    fragColor = vec4(0.25*(hrgb(w1) + hrgb(w2) + hrgb(w3) + hrgb(w4)), 1.0);
    */
}