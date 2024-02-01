//////////////////////////////////////////////////////////////
// ShaderToy HLSL translation
//////////////////////////////////////////////////////////////

#define float4 vec4
#define float3 vec3
#define float2 vec2
#define const

float saturate(float color)
{
	return clamp(color, 0.0, 1.0);
}

float2 saturate(float2 color)
{
	return clamp(color, 0.0, 1.0);
}

float3 saturate(float3 color)
{
	return clamp(color, 0.0, 1.0);
}

float4 saturate(float4 color)
{
	return clamp(color, 0.0, 1.0);
}



//////////////////////////////////////////////////////////////
// Main
//////////////////////////////////////////////////////////////
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 glUV = fragCoord.xy / iResolution.xy;	
	float4 cvSplashData = float4(iResolution.x, iResolution.y, iTime, 0.0);	
	float2 InUV = glUV * 2.0 - 1.0;	
	
	//////////////////////////////////////////////////////////////
	// End of ShaderToy Input Compat
	//////////////////////////////////////////////////////////////
	
	// Constants
	float TimeElapsed		= cvSplashData.z;
	float Brightness		= sin(TimeElapsed) * 0.1;
	float2 Resolution		= float2(cvSplashData.x, cvSplashData.y);
	float AspectRatio		= Resolution.x / Resolution.y;
	float3 InnerColor		= float3( 0.50, 0.50, 0.50 );
	const float3 OuterColor	= float3( 0.00, 0.95, 0.00 );
	const float3 WaveColor	= float3( 0.00, 1.00, 0.00 );
		
	// Input
	float2 uv				= (InUV + 1.0) / 2.0;

	// Output
	float4 outColor			= float4(0.0);

	// Positioning 
	float2 outerPos			= -0.5 + uv;
	outerPos.x				*= AspectRatio;

	float2 innerPos			= InUV * ( 2.0 - Brightness );
	innerPos.x				*= AspectRatio;

	// "logic" 
	float innerWidth		= length(outerPos);	
	float circleRadius		= 0.24 + Brightness * 0.1;
	float invCircleRadius 	= 1.0 / circleRadius;	
	float circleFade		= pow(length(3.0 * outerPos), 0.5);
	float invCircleFade		= 1.0 - circleFade;
	float circleIntensity	= pow(invCircleFade * max(1.1 - circleFade, 0.0), 2.0) * 0.0;
  	float circleWidth		= dot(innerPos,innerPos);
	float circleGlow		= ((1.0 - sqrt(abs(1.0 - circleWidth))) / circleWidth) + Brightness * 0.5;
	float outerGlow			= 0.0;//min( max( 1.0 - innerWidth * ( 1.0 - Brightness ), 0.0 ), 1.0 );
	float waveIntensity		= 0.0;
	float invWaveIntensity 	= 0.0;
	
	// Inner circle logic
	if( innerWidth < circleRadius )
	{
		
		circleGlow			*= pow(innerWidth * invCircleRadius, 24.0);
		float waveWidth		= 0.05;
		float2 waveUV		= InUV;

		waveUV.y			+= 0.14 * cos(TimeElapsed + (waveUV.x * 2.0));
		waveIntensity		+= abs(1.0 / (40.0 * waveUV.y));
			
		waveUV.x			+= 0.14 * sin(TimeElapsed + (waveUV.y * 2.0));
		waveIntensity		+= abs(1.0 / (40.0 * waveUV.x));

		waveIntensity		*= 1.0 - pow((innerWidth / circleRadius*1.1), 1.15);
		waveIntensity		= pow(waveIntensity, 3.0);
		waveIntensity		= clamp(waveIntensity, 0.0, 1.0);
		invWaveIntensity 	= 1.0 - waveIntensity;
		
		
		circleIntensity 	= invWaveIntensity;
		circleIntensity		*= 1.0-pow(innerWidth * invCircleRadius, 4.0);
	}	

	// Compose outColor
	outColor.rgb	= outerGlow * OuterColor;	
	outColor.rgb	+= circleIntensity * InnerColor;	
	outColor.rgb	+= circleGlow * OuterColor;
	outColor.rgb	+= WaveColor * waveIntensity;
	outColor.rgb	+= circleIntensity * InnerColor;
	outColor.a		= 1.0;

	// Fade in
	outColor.rgb	= clamp(outColor.rgb, 0.0, 1.0);
	outColor.rgb	*= min(TimeElapsed / 2.0, 1.0);
	
	
	
	//////////////////////////////////////////////////////////////
	// Start of ShaderToy Output Compat
	//////////////////////////////////////////////////////////////

	fragColor = outColor;
}