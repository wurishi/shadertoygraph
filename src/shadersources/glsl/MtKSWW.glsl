// Dynamism by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MtKSWW
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// Contact the author for other licensing options

/*
	Mostly about showing divergence based procedural noise, the rest is just me
	playing around to make it somewhat interesting to look at.

	I stumbled upon this new form of noise while playing with noise gradients
	and noise diverengence. First generate more or less standard fbm (with high decay)
	then compute the gradient of that noise (either numerically or analytically) and 
	then compute the divergence of the gradient and you get the noise you see here.

	As you can see it has a very "DLA" look to it. It is also very easy to animate as
	you can simply offset the noise fetches inside the initial fbm generation and produce
	good looking animated noise. I did some	testing and the paremeters can be modified 
	to result in a decent variety of output	noises, altough still somewhat similar than
	what is seen here.

	I have not tested it yet, but this method should extend to 3D without issues
	and should result in interesting volumes.

	This shader used to run at 60fps with webGL 1 but since webGL it seems
	capped at 30fps on my test computer.
*/

const vec2 center = vec2(0,0);
const int samples = 15;
const float wCurveA = 1.;
const float wCurveB = 1.;
const float dspCurveA = 2.;
const float dspCurveB = 1.;

#define time iTime

float wcurve(float x, float a, float b)
{
    float r = pow(a + b,a + b)/(pow(a, a)*pow(b, b));
    return r*pow(x, a)*pow(1.0 - x, b);
}

float hash21(in vec2 n){ return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453); }

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 p = fragCoord/iResolution.xy;
    vec2 mo = iMouse.xy/iResolution.xy;
	
    vec2 center= mo;
    center = vec2(0.5,0.5);
    
    vec3  col = vec3(0.0);
    vec2 tc = center - p;
    
    float w = 1.0;
    float tw = 1.;
    
    float rnd = (hash21(p)-0.5)*0.75;
    
    //derivative of the "depth"
    //time*2.1 + ((1.0+sin(time + sin(time*0.4+ cos(time*0.1)))))*1.5
    float x = time;
    float drvT = 1.5 * cos(x + sin(0.4*x + cos(0.1*x)))*(cos(0.4*x + cos(0.1*x)) * (0.4 - 0.1*sin(0.1*x)) + 1.0) + 2.1;
    
    
    float strength = 0.01 + drvT*0.01;
    
    for(int i=0; i<samples; i++)
    {
        float sr = float(i)/float(samples);
        float sr2 = (float(i) + rnd)/float(samples);
        float weight = wcurve(sr2, wCurveA, wCurveB);
        float displ = wcurve(sr2, dspCurveA, dspCurveB);
        col += texture( iChannel0, p + (tc*sr2*strength*displ)).rgb*weight;
        tw += .9*weight;
    }
    col /= tw;

	fragColor = vec4( col, 1.0 );
}