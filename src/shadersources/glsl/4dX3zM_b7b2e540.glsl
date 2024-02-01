
#define fNumPoints 30.0
#define iNumPoints 30

vec2 pointList[iNumPoints];
vec4 result;

float speedUp = 1.8;

void populatePointList()
{
	// Create a circle of points
	float fStep = 2.0 * 3.14159 / ((fNumPoints - 5.0) / 2.0) + 0.005 * cos(0.1 * iTime);
	float fOffset = 0.0;
	
	int n = 0;
	for (int i = 0; i < (iNumPoints - 5) / 2; i++)
	{
		fOffset += fStep;
		pointList[i] = vec2(0.5 + 0.4 * sin(fOffset), 0.5 + 0.4 * cos(fOffset + 0.1 * sin(iTime)) + fOffset * 0.01 * sin(0.5 * iTime));
		pointList[i].x += (1.0 - 3.0 * mod(float(i), sin(iTime * 0.1) * 0.01 + 3.0)) * 0.01 * sin(iTime * speedUp) * fStep;
		pointList[i].y += 0.02 * cos(iTime * speedUp * 2.0 * fStep) * fStep;
        n = i;
	}
	
	for (int i = iNumPoints - 5 / 2; i < iNumPoints - 5; i++)
	{
		fOffset += fStep;
		pointList[i] = vec2(0.5 + 0.1 * cos(fOffset), 0.5 + 0.1 * sin(fOffset));
		
		pointList[i].x += (1.0 - 2.0 * mod(float(i), 2.0)) * 0.016 * sin(iTime * speedUp * 0.3) * fStep;
		pointList[i].y += 0.028 * cos(iTime * speedUp * 2.4 * fStep) * fStep;
	}	
	
	pointList[25] = vec2(0.01 * cos(iTime * 2.0 * speedUp), 0.0);
	pointList[26] = vec2(1.0, 0.01 * sin(iTime * 2.0 * speedUp));
	pointList[27] = vec2(1.0, 1.0);
	pointList[28] = vec2(0.01 * cos(iTime * speedUp * 2.0), 1.0);
	pointList[29] = vec2(0.5 + 0.012 * cos(iTime * speedUp * 2.0), 0.5 + 0.008 * cos(iTime * speedUp));
}

void processPointList(vec2 fragCoord)
{
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 mouse = iMouse.xy / iResolution.xy;
	vec2 highlight = vec2(0.5, 0.5) + 0.51 * vec2(sin(iTime) * 0.5 , cos(iTime) *  0.5);
	float mouseD = pow(1.0 - distance(highlight, uv), 18.0);
	
	// Find closest point to this pixel
	float d = 1.0, minD = 1.0, minD2 = 1.0;
	
	for (int i = 0; i < iNumPoints; i++) minD = min(distance(pointList[i], fragCoord.xy / iResolution.xy), minD);			
	
	result.g = pow(minD * 4.0, 2.0) + 8000.0 * pow(max(0.0, (0.05 - minD)),4.0) / max(0.0, (0.05 - minD));
	result.r = result.b = mouseD * 50.0 * pow(minD * 4.0, 8.0) + 15000.0 * pow(max(0.0, (0.05 - minD)),4.0) / max(0.0, (0.05 - minD));;
	result.r = max(0.0, result.r);
    result.b = max(0.0, result.b);
    result.g = max(0.0, result.g);
    result.r += pow(minD, 2.0) * 20.0;
    result.b += pow(minD, 2.0) * 10.0 + result.g * 2.0;
}	

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
	
	populatePointList();

	processPointList(fragCoord);

	fragColor = result;

}