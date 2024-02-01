#define SHADERTOY 1 //Shadertoy compatibility (no texture)
#define USE_TEXTURE (1 && !SHADERTOY) //Texture VS Fit function (if not Shadertoy)

#define SHOW_FILTERS 0
#define SHOW_EXTINCTIONLAW 0
#define SHOW_BLACKBODIES 0
#define SHOW_FILTERED_BLACKBODY 0

vec2 FragCoord;
vec4 FragColor;

#if SHADERTOY
vec2 u_windowResolution;
vec2 u_mousePosition;
const int u_wavelengthResolution = 2999;

bool keyToggle(int ascii) 
{
	return (texture(iChannel2,vec2((.5+float(ascii))/256.,0.75)).x > 0.);
}
bool u_luminosityLog;

#else
uniform vec2 u_windowResolution;
uniform vec2 u_mousePosition;
uniform int u_wavelengthResolution;
uniform bool u_luminosityLog;
uniform sampler1D filterTex;
uniform sampler1D extinctionLawTex;
#endif

const float h = 6.62617e-34;//Planck constant   (J.s )
const float c = 299792458.; //Speed of light    (m.s-1)
const float k = 1.38066e-23;//Boltzmann constant(J.K-1)
const float zSol = 0.0132;  //Sun metallicity
const float pi = 3.141593;
const float twohcc = 2.*h*c*c;
const float hc_k = h*c/k;

float blackBodyLum( float lambda, float t)
{
    return twohcc/( lambda*lambda)/(lambda*lambda*lambda * (exp(float(hc_k/(lambda*t)))-1.) );
}

vec3 blackBodyLum3( float lambda, vec3 t)
{
    return vec3( blackBodyLum( lambda, t.r)
               , blackBodyLum( lambda, t.g)
               , blackBodyLum( lambda, t.b)
               );
}

float starLum( float lambda, float t, float r )
{
    return 4.*pi*pi*r*r * blackBodyLum( lambda, t);
}

vec3 filtering( float normalizedLambda )
{
#if USE_TEXTURE
    return texture1D(filterTex,normalizedLambda).xyz;
#else
    float lambda = normalizedLambda*float(u_wavelengthResolution)*1.e-9;
    float fitB = max( step(lambda,418.e-9)*(-8.366+2.289150e-2*1e9*lambda)
                   +  step(418.e-9,lambda)* (4.759841 - 8.846811e-3*1e9*lambda)
                   , 0.);
                ;
    float fitV = max( step(lambda,525.e-9)*(-1.092890e1+2.292683e-2*1e9*lambda)
                   + step(525.e-9,lambda) * (5.147796 - 7.875564e-3*1e9*lambda)
                   , 0.);
                ;
    float fitR = max( step(lambda,600.e-9)*(-1.079657e1+1.999566e-2*1e9*lambda)
                   + step(600.e-9,lambda) * (3.501976 - 4.144621e-3*1e9*lambda)
                   , 0.);
                ;     
    return vec3(fitR,fitV,fitB);
#endif
}

float extinctionLaw( float normalizedLambda )
{
#if USE_TEXTURE
    return texture1D(extinctionLawTex,normalizedLambda);
#else
    float lambda = normalizedLambda*float(u_wavelengthResolution)*1.e-9;
    return 6.001745e2*1.e-9/lambda;
#endif
}

bool affSlider(vec2 p0, vec2 dp, float v)
{
	float R=5.;
	vec2 pix = FragCoord.xy/u_windowResolution.y;
	float pt = max(1e-2,1./u_windowResolution.y); R*=pt;
	pix -= p0;

	float dp2 = dot(dp,dp);
	float x = dot(pix,dp)/dp2; if ((x<0.)||(x>1.)) return false;
	float x2=x*x;
	float y = dot(pix,pix)/dp2-x2; if (y>R*R) return false;

	FragColor = vec4(1.,.2,0.,1.); 
	y = sqrt(y);
	if (y<pt) return true;       // rule
	vec2 p = vec2(x-v,y);
	if (dot(p,p)<R*R) return true; // button
	
	return false;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
#if SHADERTOY
	u_windowResolution = iResolution.xy;
	u_mousePosition = iMouse.xy;
#endif
    
    u_luminosityLog =  keyToggle(49);
    
    FragCoord = fragCoord;
	FragColor = vec4(0.);	
    
    vec2 normFragCoord = fragCoord.xy/u_windowResolution;
    vec2 normMouse = u_mousePosition/u_windowResolution;

	if (affSlider(vec2(.05,.02),vec2(.4,0),normMouse.x)) { fragColor=FragColor; return;}
	if (affSlider(vec2(.02,.05),vec2(0,.4),normMouse.y)) { fragColor=FragColor; return;} 
	
#if SHOW_FILTERS

    vec3 filterValue = filtering(normFragCoord.x);
    fragColor = vec4(step(normFragCoord.yyy,filterValue), 1. );

#elif SHOW_EXTINCTIONLAW

    float extinctionLawValue = extinctionLaw(normFragCoord.x);
    fragColor = vec4(vec3(step(normFragCoord.y,extinctionLawValue*.1)), 1. );
    
#elif SHOW_BLACKBODIES

    float radianceMax = 1.e15;
    vec3 temperature= vec3(10000.,8000.,6000.);

    float lambda = normFragCoord.x*float(u_wavelengthResolution)*1.e-9;
    vec3 blackBodyValue = blackBodyLum3(lambda,temperature);
    fragColor = vec4( step(normFragCoord.y*radianceMax, blackBodyValue), 1. );
    
#elif SHOW_FILTERED_BLACKBODY

    float radianceMax = 1.e15;
    float temperature = 10000.;
    
    vec3 filterValue = filtering(normFragCoord.x);
    float lambda = normFragCoord.x*float(u_wavelengthResolution)*1.e-9;
    float blackBodyValue = blackBodyLum(lambda,temperature);
    fragColor = vec4( step( normFragCoord.y, blackBodyValue*filterValue/radianceMax ), 1. );
    
#else
    
	//temperature
    float tmax = 50000.;
    float tmin = 3000.;
	//column density
    float dmax = 9000.;
    float dmin = 0.000001;
    
	const float albedo = .1;
	const float phase = 1./(4.*pi);
	const float NDotE = 1.;
	float NDotL = mix(0.,1.,normMouse.x);
	
	bool transparency = normFragCoord.x < 0.5;//transparency computation on the left of the screen, scattering on the right 
    float t = tmax*exp(mod(normFragCoord.x,.5)*2. * log(tmin/tmax));//abscissa : temperature
    float d = dmax*exp(normFragCoord.y * log(dmin/dmax));//ordinate : column density
    float vBandOpticalDepth = 0.4*log(10.)*d/(9.*zSol);//optical depth in Visible Band
	
    vec3 filteredBlackBody = vec3(0.,0.,0.);
    vec3 filteredExtinctedBlackBody = vec3(0.,0.,0.);
    //vec3 filteredStarLum = vec3(0.,0.,0.);
    const int lambdaStep = 50;
    for ( int lambdaIndex = 0; lambdaIndex < u_wavelengthResolution; lambdaIndex+=lambdaStep)
    {
        float lambda = (float(lambdaIndex)+0.5)*1.e-9;
        
        float lambdaCoord = (float(lambdaIndex)+0.5)/float(u_wavelengthResolution);
        vec3 filterValue = filtering(lambdaCoord);
        float extinctionLawValue = extinctionLaw(lambdaCoord);
        
        float blackBody = blackBodyLum(lambda,t);
        vec3 filteredBlackBodyDeltaLambda = blackBody * float(lambdaStep)*1.e-9 * filterValue;
		vec3 filteredExtinctedBlackBodyDeltaLambda = vec3(0.);
		if ( transparency )//transparency
		{
			filteredExtinctedBlackBodyDeltaLambda = filteredBlackBodyDeltaLambda * exp(-vBandOpticalDepth*extinctionLawValue);
		}
		else //scattering
		{
			filteredExtinctedBlackBodyDeltaLambda = filteredBlackBodyDeltaLambda * albedo * phase * NDotL/(NDotL+NDotE) * (1.-exp(-vBandOpticalDepth*extinctionLawValue*(1./NDotL+1./NDotE)));
		}
        filteredBlackBody += filteredBlackBodyDeltaLambda;
        filteredExtinctedBlackBody += filteredExtinctedBlackBodyDeltaLambda;
        
        // float starLumValue = starLum(lambda,t,7.e8);
        // filteredStarLum   += starLumValue   * float(lambdaStep)*1.e-9 * filterValue * exp(-0.4*log(10.)*d/(9.*zSol));
    }
    
	if(u_luminosityLog) //log(luminosity)
	{
		float gain = mix(1.e6,1.e3,normMouse.y);
		fragColor = vec4(log(filteredExtinctedBlackBody/gain)/log(10.)/4.,1.);
		//fragColor = vec4(log(filteredStarLum/3.839e26*100.)/log(10)/2.,1.);
	}
	else
	{
		float gain = pow(10.,mix(10.,5.,normMouse.y));
		float filteredBlackBodyNorm = dot(filteredBlackBody,vec3(1));
		fragColor = vec4(filteredExtinctedBlackBody/gain,1.);
	}

#endif
}