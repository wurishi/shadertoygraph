const vec3 cameraPosition = vec3(0.5, 0.5, 1);

//ray-sphere intersection
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
  return min(t0,t1);
    
}

//Lambert shading
vec4 getColor(vec3 p, vec3 center, vec4 diffuseColor, vec3 lightPosition)
{
  vec3 n = p - center;
  n = normalize(n);
  vec3 l = lightPosition - p;
  l = normalize(l);  
  return diffuseColor * max(0.0, dot(n,l));
}  

vec4 drawSphere(vec3 rayDir, vec3 pos, float r, vec4 color, vec3 light)
{
  vec4 outColor = vec4(-1,-1,-1,-1); 	
  float t = intersect(cameraPosition, rayDir, pos, r);
  if(t > -1.0)
    outColor = getColor(cameraPosition + t*rayDir, pos, color, light);
  
  return outColor;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec3 normalizedPosition = vec3(fragCoord.xy / iResolution.x, 0);
  vec2 normalizedMouse = iMouse.xy / iResolution.x;
  vec3 rayDir = normalizedPosition - cameraPosition;
  rayDir = normalize(rayDir);

  vec4 outColor = vec4(0,0,1,1);	
  //Light
  vec3 lightPosition = vec3(normalizedMouse, 0);	
	
  //Sphere1
  vec3 pos = vec3(1.3,0.2,-1.8);
  vec4 color = vec4(1,0,0,1);
  float r = 0.3;
  vec4 sphereColor = drawSphere(rayDir, pos, r, color, lightPosition);
  if(sphereColor.x != -1.0)
    outColor = sphereColor;
  
  //Sphere2
  pos = vec3(0.3,0.2,-0.8);
  color = vec4(1,1,0,1);
  r = 0.3;
  sphereColor = drawSphere(rayDir, pos, r, color, lightPosition);
  if(sphereColor.x > -1.0)
    outColor = sphereColor;
    
  fragColor = outColor;
  
}