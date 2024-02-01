// Simple raymarcher
// psde, 2013

const float EPSILON = 0.00001;
const int MAX_ITERATIONS = 256;
const float MAX_DEPTH = 128.0;

struct Camera
{
	vec3 position;
	vec3 dir;
	vec3 up;
	vec3 rayDir;
	vec2 screenPosition;
};

struct Material
{
	vec3 color;
};
	
struct MapResult
{
	float dist;
	Material material;
};
	
struct MarchResult
{
	MapResult hit;
	vec3 position;
	vec3 normal;
};

Camera getCamera(in vec3 dir, in vec3 position, in vec3 up, in vec2 fragCoord)
{
	Camera cam;
  	cam.dir = dir;
	cam.position = position;
	cam.up = up;
  	vec3 forward = normalize(cam.dir - cam.position);
  	vec3 left = cross(forward, cam.up);
 	cam.up = cross(left, forward);
 
	vec3 screenOrigin = (cam.position+forward);
	cam.screenPosition = 2.0*fragCoord.xy/iResolution.xy - 1.0;
 	float screenAspectRatio = iResolution.x/iResolution.y;
	vec3 screenHit = screenOrigin + cam.screenPosition.x * left * screenAspectRatio + cam.screenPosition.y * cam.up;
  
	cam.rayDir = normalize(screenHit-cam.position);
	return cam;
}

mat4 rotationMatrix(vec3 axis, float angle)
{
	axis = normalize(axis);
	float s = sin(angle);
	float c = cos(angle);
	float oc = 1.0 - c;
	return mat4(oc * axis.x * axis.x + c, oc * axis.x * axis.y - axis.z * s, oc * axis.z * axis.x + axis.y * s, 0.0,
		    oc * axis.x * axis.y + axis.z * s, oc * axis.y * axis.y + c, oc * axis.y * axis.z - axis.x * s, 0.0,
		    oc * axis.z * axis.x - axis.y * s, oc * axis.y * axis.z + axis.x * s, oc * axis.z * axis.z + c, 0.0,
		    0.0, 0.0, 0.0, 1.0);
}

MapResult combine(MapResult a, MapResult b)
{
	if(a.dist < b.dist)
	{
		return a;	
	}
	return b;
}

MapResult map_cube(vec3 position)
{
	MapResult result;
	result.material.color = vec3(1.0, 0.5, 0.2);
	
	float cube = length(max(abs(position) - vec3(1.2), 0.0)) - 0.1;
	
	float sphere = length(position) - 1.6 - (0.1 + sin(iTime) * 0.2);
	
	float d = max(cube, -sphere);
		
	result.dist = d;
	return result;
}

MapResult map_torus(vec3 position)
{
	MapResult result;
	result.material.color = vec3(0.0, 0.5, 0.8);
	
	position = (rotationMatrix(vec3(0,0,1), iTime) * vec4(position, 1.0)).xyz;
	position = (rotationMatrix(vec3(0,1,0), iTime) * vec4(position, 1.0)).xyz;
	position = (rotationMatrix(vec3(1,0,0), iTime) * vec4(position, 1.0)).xyz;
	
	vec2 q = vec2(length(position.xz) - 2.5, position.y);
	result.dist = length(q) - 0.2;
			
	return result;
}

MapResult map_floor(vec3 position)
{
	MapResult result;
	result.dist = dot(position, vec3(0.0, 1.0, 0.0)) + 2.5;
	result.material.color = textureLod(iChannel0, position.xz * 0.15, 0.0).rgb;
	
	return result;
}

MapResult map(vec3 position)
{
	MapResult result;
	
	result = map_floor(position);
	
	result = combine(result, map_cube(position));
	result = combine(result, map_torus(position));
		
	return result;
}

MarchResult raymarch(const in Camera cam)
{
	MarchResult march;
	
	float depth = 0.0;
	for(int i = 0; i < MAX_ITERATIONS; ++i)
	{
		march.position = cam.position + cam.rayDir * depth;
		march.hit = map(march.position);
		
		
		if(march.hit.dist <= EPSILON || depth >= MAX_DEPTH)
		{
			break;
		}
		
		depth += march.hit.dist;
	}
	
	if(depth < MAX_DEPTH)
	{
		vec3 eps = vec3(EPSILON, 0, 0);
		march.normal=normalize(
			   vec3(march.hit.dist - map(march.position-eps.xyy).dist,
					march.hit.dist - map(march.position-eps.yxy).dist,
					march.hit.dist - map(march.position-eps.yyx).dist));
		
	}
	
	return march;
}

vec3 getColor(const in Camera cam, const in MarchResult march)
{	
	float lambert = dot(march.normal, -cam.rayDir);
	
	vec3 color = lambert * march.hit.material.color;
	
	return color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{	
	// Set up camera
  	vec3 cam_dir = vec3(0,0,0);
	float t = (iTime+3.0) * 0.15;
	vec3 cam_position = vec3(sin(t + 1.0)*4.0, 5, cos(t)*4.0);
	vec3 cam_up = vec3(0,1,0);
	
	Camera cam = getCamera(cam_dir, cam_position, cam_up, fragCoord);
	
	// Raymarch
	MarchResult result = raymarch(cam);
	
	vec3 color = getColor(cam, result);
	
	fragColor = vec4(color, 1.0);
}