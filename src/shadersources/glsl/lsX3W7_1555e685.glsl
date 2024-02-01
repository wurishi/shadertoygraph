const vec3 cameraPosition = vec3(0.5, 0.5, 1);

//Ray-Sphere intersection
float intersect(vec3 rayOrigin, vec3 rayDir, vec3 sphereCenter, float radius)
{
  float a = dot(rayDir, rayDir);
  float b = dot(rayOrigin - sphereCenter, rayDir);
  float c = dot(rayOrigin - sphereCenter, rayOrigin - sphereCenter) - radius*radius;
  
  float discr = b*b - a*c;
  if(discr < 0.0)
    return -1.0;
  
    discr = sqrt(discr);
    float t0 = (-b - discr) / a;
    float t1 = (-b + discr) / a;
  
	return min(t0, t1);
}

//Blinn-Phong shading
vec4 getColor(vec3 p, vec3 center, vec4 diffuseColor, vec3 lightPosition)
{
  vec3 n = p - center;
  n = normalize(n);
  vec3 l = lightPosition - p;
  l = normalize(l);  
  vec3 v = cameraPosition - p;
  v = normalize(v);
  vec3 h = v + l;
  h = normalize(h);
  return diffuseColor * max(0.0, dot(n,l)) + vec4(1.0,1.0,1.0,1.0) * max(0.0, pow(dot(n,h), 100.0));
}  

//Sphere intersect and shade
vec4 drawSphere(vec3 rayDir, vec3 pos, float r, vec4 color, vec3 light, out float t, out vec3 p)
{
  vec4 outColor = vec4(-1,-1,-1,-1); 	
  t = intersect(cameraPosition, rayDir, pos, r);
  if(t > -1.0)
  {
	p = cameraPosition + t*rayDir;  
    outColor = getColor(p, pos, color, light);	
  }
  return outColor;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec3 normalizedPosition = vec3(fragCoord.xy / iResolution.x, 0);
  vec2 normalizedMouse = iMouse.xy / iResolution.x;
  vec3 rayDir = normalizedPosition - cameraPosition;
  rayDir = normalize(rayDir);

  vec4 outColor = vec4(0.0,0.0,0.0,1);  	

  //Light
  vec3 lPos = vec3(2.5, 4.0, 0.0);	
	
  //Central sphere
  vec3 sPos = vec3(normalizedMouse.x * cos(iTime) + 0.5,0.8,-5.0 + normalizedMouse.y *sin(iTime));
  float sR = 0.55;
  vec4 sColor = vec4(1.0,0.0,0.0,1.0);
  float sT;
  vec3 sP;	
  vec4 sShadeColor = drawSphere(rayDir, sPos, sR, sColor, lPos, sT, sP);
  if(sShadeColor.x > -1.0)
    outColor = sShadeColor;	
  	
  //Oscillating spheres
  for(int z=10; z >= 0; z--)
  {
  	for(int x = -5; x < 5; x++)
	{
  		vec3 pos = vec3(x ,sin(iTime + float(z)/3.0 + float(x)/3.0) - 1.5,-z);
  		float r = 0.15;
		vec4 color = vec4(0.0,0.5,0.5,1.0);
  		float t;
		vec3 p;
  		vec4 sphereColor = drawSphere(rayDir, pos, r, color, lPos, t, p);
  		if(sphereColor.x > -1.0)
		{
    		outColor = sphereColor;
		
			//Shadow
			vec3 shadowDir = normalize(lPos - p);
			float tShadow = intersect(p, shadowDir, sPos, sR);
			if(tShadow > -1.0)
				outColor = vec4(0.1,0.1,0.1,1.0);
		}
	
	}
  }
	
  fragColor = outColor;
  
}