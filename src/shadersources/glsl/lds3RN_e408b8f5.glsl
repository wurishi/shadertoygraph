//Mercury
//by
//Kleber Garcia 2013 (c)

const float EPSILON = 0.001;

vec3 sphere1Pos;
const float sphere1Rad = 2.0;
const vec3 sphere1Col = vec3(0.0,1.0,1.0);
const vec3 dx = vec3(EPSILON, 0, 0);
const vec3 dy = vec3(0, EPSILON, 0);
const vec3 dz = vec3(0, 0, EPSILON);
vec3 lightDir = normalize(vec3(20.0, -1.0, 1.0));
float lightDistance = 10000.0;

vec3 waterNormal = normalize(vec3(-0.45,0.45,-0.1));
vec3 waterPos = vec3(0,-0.10,0);
vec3 waterCol = vec3(0.4,0.4,0.4);
vec3 fogCol = vec3(0.6, 0.9, 1.0);
float fogLimit = 5.40;

float zPlaneDist = 1000.0;
const vec3 zPlaneCol = vec3(0.0,0.0,0.0);

float sphere(const in vec3 pos, const in vec3 loc, const in float rad)
{
	return length(pos - loc) - rad;
}

float zPlane(const in vec3 pos)
{
	return zPlaneDist - pos.z;
}

float water(const in vec3 pos)
{
	vec3 vecToCenter = pos - waterPos;
	vec3 axisU = normalize(cross(waterNormal, vec3(0,0,1)));
	vec3 axisV = normalize(cross(axisU, waterNormal));
	float posU = dot(vecToCenter, axisU);
	float posV = dot(vecToCenter, axisV);
	return dot(waterNormal, vecToCenter) + (1.0 - pos.z*(1.0/60.0))* (0.005*cos(20.0*posU + 5.0*iTime) + 0.07*sin(30.0*posV+2.0*iTime));
}

float scene(const in vec3 pos, const in vec3 rayDir)
{
	float dist = sphere(pos, sphere1Pos, sphere1Rad);
	dist = min(zPlane(pos), dist); 
	dist = min(water(pos),dist);
	return dist;
}

vec3 sceneColor(const in vec3 pos, const in float shadowStep)
{
	vec3 c = zPlaneCol;
	float z = zPlane(pos);
	float s = sphere(pos, sphere1Pos, sphere1Rad);            
	float w = water(pos);
	
	float d = min(z,min(s,w)); 
	
	if (d == z)
	{
		c = zPlaneCol;
	}
	else if (d == s)
	{
		c = sphere1Col;
	}
	else if (d == w)
	{
		c = waterCol+ shadowStep*pos.z*(1.0/( 4.0))*vec3(1,1,1);//this adds some baddas blum on the mercury		
	}
	
	return c;
}

vec3 raymarch(const in vec3 origin, const in vec3 rayDir)
{
	float direction =  EPSILON + 1337.0;//number not epsilon
	vec3 o = origin;
	bool finished = false;
	for (int i = 0; i < 45; ++i)
	{
		if (direction > EPSILON)
		{
			direction = scene(o, rayDir);
			o += direction*rayDir;
		}
		
	}
	return o;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float aspect = iResolution.x / iResolution.y;
    sphere1Pos = vec3(-2.0,3.0, 2.0) + vec3(0.2,0.2,0.2) * 3.0*sin(0.5*iTime);

    vec2 screenPos = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
	screenPos.x *= aspect;
	vec2 uv = screenPos * 0.5 + 0.5;
	vec3 rayDir = normalize(vec3(screenPos, 2.0));
	vec3 origin = vec3(0,0,-4);
	vec3 color = vec3(0,0,0);
	origin = raymarch(origin, rayDir);
	
	
	vec3 normal = normalize(vec3(scene(origin - dx, rayDir) - scene(origin + dx, rayDir), scene(origin - dy, rayDir) - scene(origin + dy, rayDir), scene(origin - dz, rayDir) - scene(origin + dz, rayDir)));
	
	
	//occlusion pass
	vec3 lightPos = origin - lightDistance*lightDir;
	
	vec3 occlusionPos = raymarch(lightPos, lightDir);
	float inShadow = min(max((length(lightPos - origin) - length(lightPos - occlusionPos)), 0.0), 7.0) / 7.0; 
	
	float shadowStep = step(inShadow, 0.9);
	float spec = shadowStep*12.45*pow(max(dot(normalize(rayDir + lightDir), normal), 0.0), 18.0);	
	float inLight = max(1.0 - inShadow, 0.25);
	
	float diffuse = max(0.2, dot(normal, lightDir));
	color = sceneColor(origin, shadowStep);
	float fogDissipation =  clamp((origin.z +4.0)/(4.0 + fogLimit), 0.3, 1.0);
	
	vec3 lightedColor = (1.0 - fogDissipation)*(vec3( color*diffuse + spec))*inLight + fogDissipation*fogCol;
	fragColor = vec4(lightedColor, 1.0);
}
