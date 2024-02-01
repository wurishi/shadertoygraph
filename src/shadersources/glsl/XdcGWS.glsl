// Shader Rally - @P_Malin

// (Uncomment FAST_VERSION in "Buf C" for a framerate boost)

// Physics Hackery using the new mutipass things.

// WASD to drive. Space = brake
// G toggle gravity
// V toggle wheels (vehicle forces)
// . and , flip car

// Restart shader to reset car

// I'll add more soon (including a fast version of the rendering code maybe :)

// Image shader - final postprocessing

#define MOTION_BLUR_TAPS 32

ivec2 addrVehicle = ivec2( 0.0, 0.0 );

ivec2 offsetVehicleParam0 = ivec2( 0.0, 0.0 );

ivec2 offsetVehicleBody = ivec2( 1.0, 0.0 );
ivec2 offsetBodyPos = ivec2( 0.0, 0.0 );
ivec2 offsetBodyRot = ivec2( 1.0, 0.0 );
ivec2 offsetBodyMom = ivec2( 2.0, 0.0 );
ivec2 offsetBodyAngMom = ivec2( 3.0, 0.0 );

ivec2 offsetVehicleWheel0 = ivec2( 5.0, 0.0 );
ivec2 offsetVehicleWheel1 = ivec2( 7.0, 0.0 );
ivec2 offsetVehicleWheel2 = ivec2( 9.0, 0.0 );
ivec2 offsetVehicleWheel3 = ivec2( 11.0, 0.0 );

ivec2 offsetWheelState = ivec2( 0.0, 0.0 );
ivec2 offsetWheelContactState = ivec2( 1.0, 0.0 );


ivec2 addrCamera = ivec2( 0.0, 1.0 );
ivec2 offsetCameraPos = ivec2( 0.0, 0.0 );
ivec2 offsetCameraTarget = ivec2( 1.0, 0.0 );

ivec2 addrPrevCamera = ivec2( 0.0, 2.0 );


/////////////////////////
// Storage

vec4 LoadVec4( in ivec2 vAddr )
{
    return texelFetch( iChannel0, vAddr, 0 );
}

vec3 LoadVec3( in ivec2 vAddr )
{
    return LoadVec4( vAddr ).xyz;
}

bool AtAddress( vec2 p, ivec2 c ) { return all( equal( floor(p), vec2(c) ) ); }

void StoreVec4( in ivec2 vAddr, in vec4 vValue, inout vec4 fragColor, in vec2 fragCoord )
{
    fragColor = AtAddress( fragCoord, vAddr ) ? vValue : fragColor;
}

void StoreVec3( in ivec2 vAddr, in vec3 vValue, inout vec4 fragColor, in vec2 fragCoord )
{
    StoreVec4( vAddr, vec4( vValue, 0.0 ), fragColor, fragCoord);
}


vec3 ApplyPostFX( const in vec2 vUV, const in vec3 vInput );

// CAMERA

vec2 GetWindowCoord( const in vec2 vUV )
{
	vec2 vWindow = vUV * 2.0 - 1.0;
	vWindow.x *= iResolution.x / iResolution.y;

	return vWindow;	
}

vec2 GetUVFromWindowCoord( const in vec2 vWindow )
{
	vec2 vScaledWindow = vWindow;
    vScaledWindow.x *= iResolution.y / iResolution.x;
    
	 return vScaledWindow * 0.5 + 0.5;
}


vec3 GetCameraRayDir( const in vec2 vWindow, const in vec3 vCameraPos, const in vec3 vCameraTarget )
{
	vec3 vForward = normalize(vCameraTarget - vCameraPos);
	vec3 vRight = normalize(cross(vec3(0.0, 1.0, 0.0), vForward));
	vec3 vUp = normalize(cross(vForward, vRight));
							  
	vec3 vDir = normalize(vWindow.x * vRight + vWindow.y * vUp + vForward * 2.0);

	return vDir;
}

vec2 GetCameraWindowCoord(const in vec3 vWorldPos, const in vec3 vCameraPos, const in vec3 vCameraTarget)
{
	vec3 vForward = normalize(vCameraTarget - vCameraPos);
	vec3 vRight = normalize(cross(vec3(0.0, 1.0, 0.0), vForward));
	vec3 vUp = normalize(cross(vForward, vRight));
	
    vec3 vOffset = vWorldPos - vCameraPos;
    vec3 vCameraLocal;
    vCameraLocal.x = dot(vOffset, vRight);
    vCameraLocal.y = dot(vOffset, vUp);
    vCameraLocal.z = dot(vOffset, vForward);

    vec2 vWindowPos = vCameraLocal.xy / (vCameraLocal.z / 2.0);
    
    return vWindowPos;
}

float GetCoC( float fDistance, float fPlaneInFocus )
{
	// http://http.developer.nvidia.com/GPUGems/gpugems_ch23.html

    float fAperture = 0.03;
    float fFocalLength = 1.0;
    
	return abs(fAperture * (fFocalLength * (fDistance - fPlaneInFocus)) /
          (fDistance * (fPlaneInFocus - fFocalLength)));  
}


// Random

#define MOD2 vec2(4.438975,3.972973)

float Hash( float p ) 
{
    // https://www.shadertoy.com/view/4djSRW - Dave Hoskins
	vec2 p2 = fract(vec2(p) * MOD2);
    p2 += dot(p2.yx, p2.xy+19.19);
	return fract(p2.x * p2.y);    
}


float fGolden = 3.141592 * (3.0 - sqrt(5.0));

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 vUV = fragCoord.xy / iResolution.xy;

    vec4 vSample = textureLod( iChannel1, vUV, 0.0 ).rgba;
	
    float fDepth = abs(vSample.w);
    
	vec3 vCameraPos = LoadVec3( addrCamera + offsetCameraPos );
	vec3 vCameraTarget = LoadVec3( addrCamera + offsetCameraTarget );
    
	vec3 vRayOrigin = vCameraPos;
	vec3 vRayDir = GetCameraRayDir( GetWindowCoord(vUV), vCameraPos, vCameraTarget );
        
    vec3 vWorldPos = vRayOrigin + vRayDir * fDepth;
    
	vec3 vPrevCameraPos = LoadVec3( addrPrevCamera + offsetCameraPos );
	vec3 vPrevCameraTarget = LoadVec3( addrPrevCamera + offsetCameraTarget );
    vec2 vPrevWindow = GetCameraWindowCoord( vWorldPos, vPrevCameraPos, vPrevCameraTarget );
    vec2 vPrevUV = GetUVFromWindowCoord(vPrevWindow);
    
    if( vSample.a < 0.0 ) 
    {
        vPrevUV = vUV;
    }
        
	vec3 vResult = vec3(0.0);
    
    float fTot = 0.0;
    
    float fPlaneInFocus = length(vCameraPos - vCameraTarget);
    
    float fCoC = GetCoC( abs(fDepth), fPlaneInFocus );
    
    float r = 1.0;
    vec2 vangle = vec2(0.0,fCoC); // Start angle
    
    vResult.rgb = vSample.rgb * fCoC;
    fTot += fCoC;
    
    float fMotionBlurTaps = float(MOTION_BLUR_TAPS);
    
    float f = 0.0;
    float fIndex = 0.0;
    for(int i=1; i<MOTION_BLUR_TAPS; i++)
    {
        vec2 vTapUV = mix( vUV, vPrevUV, f / fMotionBlurTaps - 0.5 );
                
        float fRand = Hash( iTime + fIndex + vUV.x + vUV.y * 12.345);
        
        // http://blog.marmakoide.org/?p=1
        
        float fTheta = fRand * fGolden * fMotionBlurTaps;
        float fRadius = fCoC * sqrt( fRand * fMotionBlurTaps ) / sqrt( fMotionBlurTaps );        
        
        vTapUV += vec2( sin(fTheta), cos(fTheta) ) * fRadius;
        
        vec4 vTapSample = textureLod( iChannel1, vTapUV, 0.0 ).rgba;
        if( sign(vTapSample.a) == sign(vSample.a) )
        {
  		  	float fCurrCoC = GetCoC( abs(vTapSample.a), fPlaneInFocus );
            
            float fWeight = fCurrCoC + 1.0;
            
    		vResult += vTapSample.rgb * fWeight;
        	fTot += fWeight;
        }
        f += 1.0;
        fIndex += 1.0;
    }
    vResult /= fTot;
        
	vec3 vFinal = ApplyPostFX( vUV, vResult );

    // Draw depth
    //vFinal = vec3(1.0) / abs(vSample.a);    
    
	fragColor = vec4(vFinal, 1.0);
}

// POSTFX

vec3 ApplyVignetting( const in vec2 vUV, const in vec3 vInput )
{
	vec2 vOffset = (vUV - 0.5) * sqrt(2.0);
	
	float fDist = dot(vOffset, vOffset);
	
	const float kStrength = 0.75;
	
	float fShade = mix( 1.0, 1.0 - kStrength, fDist );	

	return vInput * fShade;
}

vec3 Tonemap( vec3 x )
{
    float a = 0.010;
    float b = 0.132;
    float c = 0.010;
    float d = 0.163;
    float e = 0.101;

    return ( x * ( a * x + b ) ) / ( x * ( c * x + d ) + e );
}

vec3 ColorGrade( vec3 vColor )
{
    vec3 vHue = vec3(1.0, .7, .2);
    
    vec3 vGamma = 1.0 + vHue * 0.6;
    vec3 vGain = vec3(.9) + vHue * vHue * 8.0;
    
    vColor *= 1.5;
    
    float fMaxLum = 100.0;
    vColor /= fMaxLum;
    vColor = pow( vColor, vGamma );
    vColor *= vGain;
    vColor *= fMaxLum;  
    return vColor;
}

vec3 ApplyGamma( const in vec3 vLinear )
{
	const float kGamma = 2.2;

	return pow(vLinear, vec3(1.0/kGamma));	
}

vec3 ApplyPostFX( const in vec2 vUV, const in vec3 vInput )
{
	vec3 vTemp = ApplyVignetting( vUV, vInput );	
	
	vTemp = vTemp * 2.0;
    
    vTemp = ColorGrade( vTemp );
    
	return Tonemap( vTemp );		
}