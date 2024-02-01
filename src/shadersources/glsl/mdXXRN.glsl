/* Creative Commons Licence Attribution-NonCommercial-ShareAlike 
   phreax 2022
*/

#define PI 3.141592
#define SIN(x) (sin(x)*.5+.5)
#define PALETTE 0

#define LINE_WIDTH 0.0001
#define MESH_DENSITY 90.
#define LAYER_DISTANCE 6.5


float tt, g_mat;
float g_gl = 0.;
vec3 ro;

// from "Palettes" by iq. https://shadertoy.com/view/ll2GD3
vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

vec3 getPal(int id, float t) {

    id = id % 7;

    vec3          col = pal( t, vec3(.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.0,-0.33,0.33) );
    if( id == 1 ) col = pal( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.0,0.10,0.20) );
    if( id == 2 ) col = pal( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,1.0),vec3(0.3,0.20,0.20) );
    if( id == 3 ) col = pal( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,1.0,0.5),vec3(0.8,0.90,0.30) );
    if( id == 4 ) col = pal( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(1.0,0.7,0.4),vec3(0.0,0.15,0.20) );
    if( id == 5 ) col = pal( t, vec3(0.5,0.5,0.5),vec3(0.5,0.5,0.5),vec3(2.0,1.0,0.0),vec3(0.5,0.20,0.25) );
    if( id == 6 ) col = pal( t, vec3(0.8,0.5,0.4),vec3(0.2,0.4,0.2),vec3(2.0,1.0,1.0),vec3(0.0,0.25,0.25) );
    
    return vec3(col);
}

mat2 rot2(float a) { return mat2(cos(a), sin(a), -sin(a), cos(a)); }


// by Nusan
float curve(float t, float d) {
  t/=d;
  return mix(floor(t), floor(t)+1., pow(smoothstep(0.,1.,fract(t)), 10.));
}

float box(vec3 p, vec3 r) {
    vec3 d = abs(p) - r;
    return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}

float rect( vec2 p, vec2 b, float r ) {
    vec2 d = abs(p) - (b - r);
    return length(max(d, 0.)) + min(max(d.x, d.y), 0.) - r;
}

vec3 transform(vec3 p) {

    float a = PI*.5 + iTime;
    p.xz *= rot2(a);
    p.xy *= rot2(a);
    
    return p;
}


vec3 repeat(inout vec3 p, vec3 size) {
	vec3 c = floor((p + size*0.5)/size);
	p = mod(p + size*0.5, size) - size*0.5;
	return c;
}

vec3 kalei(vec3 p) {

    p.x = abs(p.x) - 2.5;
    
    
    vec3 q = p;

    q.y -= .5;
    q.y += .4*sin(tt);
    p.y += .3*sin(p.z*3.+.5*tt);
    float at = length(q) - .01;
    for(float i=0.; i < 6.; i++) {     
        p.x = abs(p.x) - 1.5;
  
        p.xz *= rot2(1.-exp(-p.z*.14*i)+.2*tt+.1*at);
        p.xy *= rot2(sin(2.*i)+.2*tt);
       // p.xz -= .4*sin(tt);
     
        p.y += 1.-exp(-p.z*.1*i);
    }
    p.x = abs(p.x) + 2.5;
    
        
    return p;
}

float opSmoothIntersection( float d1, float d2, float k ) {
    float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) + k*h*(1.0-h); 
}


float opSmoothUnion( float d1, float d2, float k ) {
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h); 
}
    
float map(vec3 p) {


    vec3 bp = p;
    
    
    p.yz *= rot2(-PI*.25);
    
    p = kalei(p);
    
    // map to log-spherical
    float r = length(p);
    p = vec3(log(r),
             acos(p.z / r),
             atan(p.y, p.x));
   

    // some heuristic computation to compensate the log scaling
    float shrink = 1./abs(p.y-PI) + 1./abs(p.y) - 1./PI;
    
    float scale = floor(MESH_DENSITY)/PI; 
    p *= scale;
    
    p.x -= tt;
    p.y -= .7;
    
    vec3 id = repeat(p, vec3(LAYER_DISTANCE, .5, .5));

    p.yz *= rot2(.25*PI);
    p.x *= shrink;
     
   // p.x = abs(p.x) - .5;
  
    g_mat = bp.y*.6+id.x+abs(bp.x*.2);
    
    float w = LINE_WIDTH;
    float d = length(p.xz) - w;
    d = min(d, length(p.xy) - w);
 
    d *= r/(scale*shrink);

   // float sp = length((bp+vec3(0, -0.4, 0))*vec3(1.1, 0.8, 1)) -1.9;
   
    float sp = length(bp*vec3(mix(3.9, 0.5, smoothstep(1.5, 1.1, pow(bp.y, 1.))) +
                              mix(2.0, 0.5, smoothstep(.0, 1.3, pow(bp.y, 10.))), .8, 1) + 
                         vec3(0, -0.4, 0)) -1.9;
                         
    sp = opSmoothUnion(sp, length(bp*vec3(1, 1, .8)- vec3(0, 2.4, 0)) - .6, .1);
   
    d = opSmoothIntersection(d, sp-.4, .5);
    

    float ball = length(bp - vec3(0, 1.1, 0.))- .1;
    g_gl += .0005/(.0001+pow(abs(ball), 4.));
    
    return d*.5;
}

// from iq
float softshadow( in vec3 ro, in vec3 rd, float mint, float maxt, float k )
{
    float res = 1.0;
    float ph = 1e20;
    for( float t=mint; t<maxt; )
    {
        float h = map(ro + rd*t);
        if( h<0.001 )
            return 0.0;
        float y = h*h/(2.0*ph);
        float d = sqrt(h*h-y*y);
        res = min( res, k*d/max(0.0,t-y) );
        ph = h;
        t += h;
    }
    return res;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;

    
   // uv *= rot2(PI*.5);
    vec3 rd = normalize(vec3(uv, .7)),
         lp = vec3(0.,2., -15);
         
    ro = vec3(0, .5, -4.);
         
    vec3 p = ro;
    vec3 col = vec3(0);
    
    float t, d = 0.1;
    
    tt = .3*iTime;
    
    float mat = 0.,
          gl  = 0.;
    vec2 e = vec2(0.0035, -0.0035);
     
    vec3 al = vec3(0);
    vec3 bg = vec3(0.035,0.094,0.125);
    
    for(float i=.0; i<80.; i++) {
    
        d = map(p);
        mat = g_mat;
        gl = g_gl;
        
        if(t > 5.) break;
        
        t += max(.01, abs(d));
        p += rd*d;
        
        // shading
        if(d < 0.006) {
          
            al = getPal(PALETTE, mat*.4);
            col +=  al/exp(t*.8);

        } 
     
    } 
    
    if(dot(col, col) < 0.001) {
        col += bg*mix(.2, 1.1, (1.5-pow(dot(uv, uv), .5)));
    }
    
    // col += 0.01*gl;
    col *= mix(.1, 1., (1.5-pow(dot(uv, uv), .2))); // vignette
    col += vec3(0.459,0.725,0.192)*mix(1., .0, smoothstep(0., .4, pow(length(uv+vec2(0, -.1)), .2)-.25)); // vignette
    col = pow(col, vec3(.6)); // gamma
    
    // Output to screen
    fragColor = vec4(col, 1.0 - t * 0.3);
}