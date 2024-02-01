/*
  2012 by Felix Weiszig
*/

#define NUM_BLOBS     120
#define BLOB_SIZE_INV 8.0

float samplev (vec2 normFragPos, float aspect)
{
  float valueAll = 0.0;
  for (int i=0; i!=NUM_BLOBS; ++i)
  {
    // create a particle
    vec3 particlePos;
    particlePos.x = sin(sin(iTime*0.05 + float(i*i)))
                  * 0.5 + 0.5;

    particlePos.y = cos(iTime*0.016 + float(i)*0.1)
                    * 0.5 + 0.5;

    // calculate its influence
    float normDist = length(normFragPos/vec2(1.0, aspect)-particlePos.xy);
    normDist = 1.0 - normDist*BLOB_SIZE_INV;
    normDist *= normDist*normDist*(0.5 - abs(0.5 - particlePos.y));
    valueAll += max(0.0, normDist);
  }
	
  return valueAll;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  float aspect      = iResolution.x/iResolution.y;
  vec2  normFragPos = fragCoord.xy / iResolution.xy;
	
  float pixelStepX  = 1.0/iResolution.x;
  float pixelStepY  = 1.0/iResolution.y;
	
	
  float sampleXL = samplev(normFragPos + vec2(-pixelStepX, 0.0), aspect);
  float sampleXR = samplev(normFragPos + vec2( pixelStepX, 0.0), aspect);
	
  float diffX = sampleXL - sampleXR;
	
  float sampleYB = samplev(normFragPos + vec2( 0.0, -pixelStepY), aspect);
  float sampleYU = samplev(normFragPos + vec2( 0.0, pixelStepY), aspect);
	
  float diffY = sampleYB - sampleYU;
	
  vec3 gradien = vec3(diffX*5.0, diffY*5.0, 0.125);
  gradien = normalize(gradien);


  float sampleCenter = samplev(normFragPos, aspect);
	
	
  // lighting
  vec3 lightPos = vec3(1.0, 1.5, 2.5);
  vec3 lightDir = normalize(lightPos - vec3(normFragPos, 0.0));
	
  // diffuse
  float nDotL   = max(0.0, dot(gradien, lightDir));
  float diffuse = nDotL;
	
  // specular
  vec3  reflectionDir  = normalize( ( ( 2.0 * gradien ) * nDotL ) - lightDir );
  vec3  viewDir        = normalize((vec3(normFragPos, 1.2)));
  float reflectDotView = max( 0.0, dot( reflectionDir,  viewDir) );
  float specular = max(0.0, pow(reflectDotView, 15.0));
	
  float value = samplev(normFragPos, aspect);

  //fragColor = vec4(gradien,1.0);
  fragColor = texture(iChannel0,
						   vec2(sampleCenter, 0.495)) * diffuse + specular;
  //fragColor = vec4(diffuse,diffuse,diffuse,1.0);
  //fragColor = vec4(specular,specular,specular,1.0);
}
