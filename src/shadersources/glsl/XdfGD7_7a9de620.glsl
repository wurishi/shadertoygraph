//const vec3 lightPosition = vec3(0.1, 0.5, 0.5);
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
  
	return min(t0, t1);
}

//Blinn phong shading
vec4 getColor(vec3 p, vec3 center, vec4 diffuseColor, vec3 lightPosition)
{
  vec3 n = p - center;
  n = normalize(n);
  vec3 l = lightPosition - p;
  float distanceToLight = length(l);
  l = normalize(l);  
  vec3 v = cameraPosition - p;
  v = normalize(v);
  vec3 h = v + l;
  h = normalize(h);
  	
  vec4 lightColor = vec4(0.7,0.7,0.7,1.0);
  vec4 attenuatedLight = lightColor;// /(10.0*distanceToLight*distanceToLight + 1.2);
  vec4 ambientComponent = diffuseColor * vec4(0.25,0.25,0.25,1.0);
  vec4 diffuseComponent = attenuatedLight * diffuseColor * max(0.0, dot(n,l));
  float shininess = 100.0;
  vec4 specularColor = vec4(1.0,1.0,1.0,1.0);
  vec4 specularComponent = attenuatedLight * specularColor * max(0.0, pow(dot(n,h), shininess));
  return /*ambientComponent +*/ diffuseComponent /*+ specularComponent*/;
}  

vec4 drawSphere(vec3 rayDir, vec3 pos, float r, vec4 color, vec3 light)
{
  float t = intersect(cameraPosition, rayDir, pos, r);
  if(t > -1.0)
    return getColor(cameraPosition + t*rayDir, pos, color, light);
  else
    return vec4(-1,-1,-1,-1);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec3 normalizedPosition = vec3(fragCoord.xy / iResolution.x, 0);
  vec2 normalizedMouse = iMouse.xy / iResolution.x;
  vec3 rayDir = normalizedPosition - cameraPosition;
  rayDir = normalize(rayDir);
    
  //Light
  vec3 lightPosition = vec3(normalizedMouse, -0.2);	
	
  //Sphere1
  vec4 outColor = vec4(0.0,0.0,1.0,1);  	

  vec3 pos = vec3(0.5 ,0.0,-0.5);
  vec4 color = vec4(1.0,0.0,0.0,1.0);
  float r = 0.25;
  vec4 sphereColor = drawSphere(rayDir, pos, r, color, lightPosition);
  if(sphereColor.x > -1.0)
    outColor = sphereColor;
    
  fragColor = outColor;
  
}