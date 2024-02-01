/*  https://www.shadertoy.com/view/ldXGzS

	Area light sampling from "Importance Sampling Techniques for Path Tracing
	in Participating Media" by Kulla and Fajardo.
	
	2013 @sjb3d

	Image is split as follows:
	
	+----------------------------------------+----------------------------------------+
	|                                        |                                        |
	| Sample scattering function in media.   |  Equi-angular sampling in media.       |
	|                                        |                                        |
	| Explicit light connections only.       |  Explicit light connections only.      |
	|                                        |                                        |
	|                                        |                                        |
	+----------------------------------------+----------------------------------------+
	|                                        |                                        |
	| Sample scattering function in media.   |  Equi-angular sampling in media.       |
	|                                        |                                        |	
	| Light source connections and           |  Light source connections and          |
	| light source hits combined with MIS.   |  light source hits combined with MIS.  |
	|                                        |                                        |
	+----------------------------------------+----------------------------------------+

	If your shader compiler is having a good day, top-left should look noisiest
	and bottom-right should look smoothest.

	Use the mouse to move the split locations.

    In order to see the effect of MIS, it is recommended to leave
    SHOW_LIGHT at the default of 0.
*/

// set to 1 to show light, 0 to hide light
#define SHOW_LIGHT		0

#define PI				3.1415926535
#define SIGMA			0.3

#define STEP_COUNT		32
#define DIST_MAX		10.0
#define LIGHT_POWER		200.0

// Chrom[e|ium] seems to allow while loops, Firefox not so much!
//#define USING_CHROME

// shamelessly stolen from iq!
float hash(float n)
{
    return fract(sin(n)*43758.5453123);
}

float getDimensionHash(int dim, vec2 fragCoord)
{
	return hash(fragCoord.y*iResolution.x + fragCoord.x + iTime + float(dim));
}

void sampleCamera(vec2 fragCoord, vec2 u, out vec3 rayOrigin, out vec3 rayDir)
{
	vec2 filmUv = (fragCoord.xy + u)/iResolution.xy;

	float tx = (2.0*filmUv.x - 1.0)*(iResolution.x/iResolution.y);
	float ty = (1.0 - 2.0*filmUv.y);
	float tz = 0.0;

	rayOrigin = vec3(0.0, 0.0, 5.0);
	rayDir = normalize(vec3(tx, ty, tz) - rayOrigin);
}

void intersectLight(
	vec3 rayOrigin,
	vec3 rayDir,
	vec3 planeNormal,
	inout float rayT,
	inout vec2 uv)
{
	vec3 planeTangent = normalize(cross(planeNormal, vec3(0.0, 1.0, 0.0)));
	vec3 planeBitangent = normalize(cross(planeNormal, planeTangent));
	
	// get coord of plane intersection
	float t = -dot(rayOrigin, planeNormal)/dot(rayDir, planeNormal);
	if (0.0 < t && t < rayT) {
		// check coord on plane is within light quad
		vec3 hitPos = rayOrigin + t*rayDir;
		float x = dot(hitPos, planeTangent);
		float y = dot(hitPos, planeBitangent);
		if (-0.5 < x && x < 0.5 && -0.5 < y && y < 0.5) {
			rayT = t;
			uv = vec2(0.5 - x, y + 0.5);
		}
	}
}

vec3 evaluateLight(vec2 uv, out float areaPdf)
{
	vec3 srgb = texture(iChannel0, uv).xyz;
	areaPdf = 1.0;
	return LIGHT_POWER*pow(srgb, vec3(2.2));
}

vec3 sampleLight(
	vec2 uv,
	vec3 planeNormal,
	out vec3 lightPos,
	out float areaPdf)
{
	vec3 planeTangent = normalize(cross(planeNormal, vec3(0.0, 1.0, 0.0)));
	vec3 planeBitangent = normalize(cross(planeNormal, planeTangent));
	float x = 0.5 - uv.x;
	float y = uv.y - 0.5;
	lightPos = x*planeTangent + y*planeBitangent;
	return evaluateLight(uv, areaPdf);
}

vec3 unitVecFromPhiCosTheta(float phi, float cosTheta)
{
	float sinPhi = sin(phi);
	float cosPhi = cos(phi);
	float sinTheta = sqrt(max(0.0, 1.0 - cosTheta*cosTheta));
	return vec3(cosPhi*sinTheta, sinPhi*sinTheta, cosTheta);
}

vec3 sampleSphereUniform(vec2 uv)
{
	float cosTheta = 2.0*uv.x - 1.0;
	float phi = 2.0*PI*uv.y;
	return unitVecFromPhiCosTheta(phi, cosTheta);
}

float getSphereUniformPdf()
{
	return 1.0/(4.0*PI);
}

void sampleScattering(
	float u,
	float maxDistance,
	out float dist,
	out float pdf)
{
	// remap u to account for finite max distance
	float minU = exp(-SIGMA*maxDistance);
	float a = u*(1.0 - minU) + minU;

	// sample with pdf proportional to exp(-sig*d)
	dist = -log(a)/SIGMA;
	pdf = SIGMA*a/(1.0 - minU);
}

void sampleEquiAngular(
	float u,
	float maxDistance,
	vec3 rayOrigin,
	vec3 rayDir,
	vec3 lightPos,
	out float dist,
	out float pdf)
{
	// get coord of closest point to light along (infinite) ray
	float delta = dot(lightPos - rayOrigin, rayDir);

	// get distance this point is from light
	float D = length(rayOrigin + delta*rayDir - lightPos);

	// get angle of endpoints
	float thetaA = atan(0.0 - delta, D);
	float thetaB = atan(maxDistance - delta, D);

	// take sample
	float t = D*tan(mix(thetaA, thetaB, u));
	dist = delta + t;
	pdf = D/((thetaB - thetaA)*(D*D + t*t));
}

// QMC in GLSL is painful!
float radicalInverse(int index, int base)
{
	float invBase = 1.0/float(base);
	float invBi = invBase;
	int n = index;
	float val = 0.0;
	// workaround for Firefox not liking while loops
#ifdef USING_CHROME
	while (n > 0) {
#else
	for (int i = 0; i < 8; ++i) { // log_base(STEP_COUNT) is enough
		if (n == 0) {
			break;
		}
#endif
		float di = mod(float(n), float(base));
		val += di*invBi;
		n = n/base;
		invBi *= invBase;
	}
	return val;
}
float getSampleDim0(int sampleIndex,vec2 fragCoord)
{
	return fract(getDimensionHash(0,fragCoord) + radicalInverse(sampleIndex, 2));
}
float getSampleDim1(int sampleIndex,vec2 fragCoord)
{
	return fract(getDimensionHash(1,fragCoord) + radicalInverse(sampleIndex, 3));
}
float getSampleDim2(int sampleIndex,vec2 fragCoord)
{
	return fract(getDimensionHash(2,fragCoord) + radicalInverse(sampleIndex, 5));
}
float getSampleDim3(int sampleIndex,vec2 fragCoord)
{
	return fract(getDimensionHash(3,fragCoord) + radicalInverse(sampleIndex, 7));
}
float getSampleDim4(int sampleIndex,vec2 fragCoord)
{
	return fract(getDimensionHash(4,fragCoord) + radicalInverse(sampleIndex, 11));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 particleIntensity = vec3(1.0/(4.0*PI));
	vec3 lightNormal = normalize(vec3(2.0*sin(iTime), 0.5, 1.0));
	
	vec3 rayOrigin, rayDir;
	sampleCamera(fragCoord, vec2(0.5, 0.5), rayOrigin, rayDir);
	
	float sampleSplitCoord = (iMouse.x == 0.0) ? iResolution.x/2.0 : iMouse.x;
	float misSplitCoord = (iMouse.y == 0.0) ? iResolution.y/2.0 : iMouse.y;

	float t = DIST_MAX;
	vec3 col = vec3(0.0);
	
#if SHOW_LIGHT		
	vec2 uv;
	intersectLight(rayOrigin, rayDir, lightNormal, t, uv);
	if (t < DIST_MAX) {
		float areaPdfUnused;
		vec3 lightIntensity = evaluateLight(uv, areaPdfUnused);
		float trans = exp(-SIGMA*t);
		col += lightIntensity*trans;
	}
#endif
	
	// max single scatter distance is light plane
	t = min(t, -dot(rayOrigin, lightNormal)/dot(rayDir, lightNormal));
	if (t > 0.0) {
		for (int stepIndex = 0; stepIndex < STEP_COUNT; ++stepIndex) {
			float u0 = getSampleDim0(stepIndex,fragCoord);
			float u1 = getSampleDim1(stepIndex,fragCoord);
			float u2 = getSampleDim2(stepIndex,fragCoord);
			float u3 = getSampleDim3(stepIndex,fragCoord);
			float u4 = getSampleDim4(stepIndex,fragCoord);
			
			// sample media along ray
			float x;
			float distPdf;
			vec3 particlePos;
		
			{
				// sample light source
				vec3 lightPos;
				float areaPdf;
				vec3 lightIntensity = sampleLight(vec2(u0, u1), lightNormal, lightPos, areaPdf);
				
				// sample particle pos
				if (fragCoord.x < sampleSplitCoord) {
					sampleScattering(u4, t, x, distPdf);
				} else {
					sampleEquiAngular(u4, t, rayOrigin, rayDir, lightPos, x, distPdf);
				}
				particlePos = rayOrigin + x*rayDir;
				
				// compute info
				vec3 lightVec = lightPos - particlePos;
				vec3 lightDir = normalize(lightVec);
				float d = length(lightVec);
				float geomTerm = abs(dot(lightDir, lightNormal))/dot(lightVec, lightVec);
				
				// compute MIS weight (and adjust for sample count)
				float phasePdf = getSphereUniformPdf();
				float weight;
				if (fragCoord.y > misSplitCoord) {
					weight = 1.0;
				} else {
					float ratio = (geomTerm*phasePdf)/areaPdf;
					weight = 1.0/(1.0 + ratio);
				}
				weight /= float(STEP_COUNT);
				
				// accumulate sample
				float trans = exp(-SIGMA*(d + x));
				col += weight*SIGMA*lightIntensity*particleIntensity*geomTerm*trans/(areaPdf*distPdf);
			}
			
			{
				// sample phase function
				vec3 phaseDir = sampleSphereUniform(vec2(u2, u3));
				float phasePdf = getSphereUniformPdf();
				
				// check for light intersection
				float d = DIST_MAX;
				vec2 uv;
				intersectLight(particlePos, phaseDir, lightNormal, d, uv);
				if (d < DIST_MAX) {
					// evaluate light
					float areaPdf;
					vec3 lightIntensity = evaluateLight(uv, areaPdf);
					
					// compute info
					float geomTerm = abs(dot(phaseDir, lightNormal))/(d*d);
					
					// compute MIS weight (and adjust for sample count)
					float weight;
					if (fragCoord.y > misSplitCoord) {
						weight = 0.0;
					} else {
						float ratio = areaPdf/(geomTerm*phasePdf);
						weight = 1.0/(1.0 + ratio);
					}
					weight /= float(STEP_COUNT);
					
					// accumulate sample
					float trans = exp(-SIGMA*(d + x));
					col += weight*SIGMA*lightIntensity*particleIntensity*trans/(phasePdf*distPdf);
				}
			}
		}
	}
	
	// show slider position
	if (abs(fragCoord.x - sampleSplitCoord) < 1.0) {
		col.x = 1.0;
	}
	if (abs(fragCoord.y - misSplitCoord) < 1.0) {
		col.z = 1.0;
	}
	col = pow(col, vec3(1.0/2.2));
	
	fragColor = vec4(col, 1.0);
}
