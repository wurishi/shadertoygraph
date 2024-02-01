float hash( float n )
{
    return fract(sin(n)*43745658.5453123);
}

float noise(vec2 pos)
{
	return fract( sin( dot(pos*0.001 ,vec2(24.12357, 36.789) ) ) * 12345.123);	
}

float noise(float r)
{
	return fract( sin( dot(vec2(r,-r)*0.001 ,vec2(24.12357, 36.789) ) ) * 12345.123);	
}


float wave(float amplitude, float offset, float frequency, float phase, float t)
{
	return offset+amplitude*sin(t*frequency+phase);
}

float wave(float amplitude, float offset, float frequency, float t)
{
	return offset+amplitude*sin(t*frequency);
}

float wave2(float min, float max, float frequency, float phase, float t)
{
	float amplitude = max-min;
	return min+0.5*amplitude+amplitude*sin(t*frequency+phase);
}

float wave2(float min, float max, float frequency, float t)
{
	float amplitude = max-min;
	return min+0.5*amplitude+amplitude*sin(t*frequency);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float colorSin = 0.0;
	float colorLine = 0.0;
	const float nSin = 50.0;
	const float nLine = 30.0;

	// Sin waves
	for(float i=0.0 ; i<nSin ; i++)
	{
        float iMouseX = (iMouse.z < 1.0) ? 0.5*iResolution.x : iMouse.x;
		float amplitude = iMouseX*1.0*noise(i*0.2454)*sin(iTime+noise(i)*100.0);
		float offset = (iMouse.z < 1.0) ? 0.5*iResolution.y : iMouse.y;
		float frequency = 0.1*noise(i*10.2454);
		float phase = noise(i*10.2454)*1.0*iTime*iMouseX/iResolution.x;
		float line = wave(amplitude,offset,frequency,phase,fragCoord.x);
		colorSin += 0.5/abs(line-fragCoord.y);
	}

	// Grid	
	for(float i=0.0 ; i<nLine ; i++)
	{
		float lx = (i/nLine)*(iResolution.x+10.0);
		float ly = (i/nLine)*(iResolution.y+10.0);
		colorLine += 0.07/abs(fragCoord.x-lx);
		colorLine += 0.07/abs(fragCoord.y-ly);
	}
	vec3 c = colorSin*vec3(0.2654, 0.4578, 0.654);
	c += colorLine*vec3(0.254, 0.6578, 0.554);
	fragColor = vec4(c,1.0);
}