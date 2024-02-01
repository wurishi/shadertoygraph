// Copyright (c) 2013 Andrew Baldwin (baldand)
// License = Attribution-NonCommercial-ShareAlike (http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US)

// Salmiakki 

vec3 rnd3(vec3 n)
{
	vec3 m = floor(n)*.00001 + fract(n);
	const mat3 p = mat3(13.323122,23.5112,21.71123,21.1212,28.7312,11.9312,21.8112,14.7212,61.3934);
	vec3 mp = (31415.9+m)/fract(p*m);
	return fract(mp);
}

struct accel {
	bool rayGoesNearSphere;
	float sphereDistance;
};

float map(vec3 pos, accel rayInfo)
{
	float sphere = length(pos - vec3(-1.,0.,0.))-.8+.2*sin(pos.y*10.)*sin(pos.z*10.)*sin(pos.x*10.+iTime);
	return sphere;
}

void calcAccel(vec3 rayOrigin, vec3 rayDirection,inout accel rayInfo)
{
	vec3 ro = rayOrigin - vec3(-1.,0.,0.);
	float a = dot(rayDirection,ro);
	float b = dot(ro,ro);
	float d = a*a - b + 1.;
	rayInfo.rayGoesNearSphere = true;
	rayInfo.sphereDistance = d;
}

vec3 normal(vec3 pos)
{
	accel rayInfo;
	calcAccel(pos,vec3(1.,0.,0.),rayInfo);
	vec3 eps = vec3(0.01,0.,0.);
	float dx = map(pos+eps.xyy,rayInfo)*100.;
	float dy = map(pos+eps.yxy,rayInfo)*100.;
	float dz = map(pos+eps.yyx,rayInfo)*100.;
	float mdx = map(pos-eps.xyy,rayInfo)*100.;
	float mdy = map(pos-eps.yxy,rayInfo)*100.;
	float mdz = map(pos-eps.yyx,rayInfo)*100.;
	return vec3(dx-mdx,dy-mdy,dz-mdz);
}

vec3 model(vec3 rayOrigin, vec3 rayDirection)
{
	float t = 0.;
	vec3 p;
	float d = 0.;
	bool nothit = true;
	accel rayInfo;
	calcAccel(rayOrigin,rayDirection,rayInfo);
	for (int i=0;i<15;i++) {
		if (nothit) {
			t += d*.6;
			p = rayOrigin + t * rayDirection;
			d = map(p,rayInfo);
			nothit = d>0.001 && t<10.;			
		}
	}
	vec3 n = normal(p);
	vec3 lightpos = vec3(4.);
	vec3 lightdist = lightpos - p;
	float light = 1.+dot(lightdist,n)*1./length(lightdist);
	vec3 m=.5+.2*abs(fract(p)*2.-1.);
	vec3 c = vec3(clamp(light,0.,10.))*vec3(m-.01*length(p));
	return c; 
}

vec3 camera(in vec2 sensorCoordinate, in vec3 cameraPosition, in vec3 cameraLookingAt, in vec3 cameraUp)
{
	vec2 uv = 1.-sensorCoordinate;
	vec3 sensorPosition = cameraPosition;
	vec3 direction = normalize(cameraLookingAt - sensorPosition);
	vec3 lensPosition = sensorPosition + 2.*direction;
	const vec2 lensSize = vec2(1.);
    vec2 sensorSize = vec2(iResolution.x/iResolution.y,1.0);
	vec2 offset = sensorSize * (uv - 0.5);
	vec3 right = cross(cameraUp,direction);
	vec3 rayOrigin = sensorPosition + offset.y*cameraUp + offset.x*right;
	vec3 rayDirection = normalize(lensPosition - rayOrigin);
	// Render the scene for this camera pixel
	float rt = 0.;//fract(iTime);
	vec3 colour = vec3(0.);
	colour += max(model(rayOrigin, rayDirection),vec3(0.));
		
	// Post-process for display
	vec3 toneMapped = colour/(1.+colour);
	// Random RGB dither noise to avoid any gradient lines
	vec3 dither = vec3(rnd3(vec3(uv.xy,iTime)))/255.;
	// Return final colour
	return toneMapped + dither;
}

vec3 world(vec2 fragCoord)
{
	// Position camera with interaction
	float rotspeed = 10.09+4.1+iTime*.3+10.*iMouse.x/iResolution.x;
	float radius = 10.+5.*sin(iTime*.2+4.);
	vec3 cameraTarget = vec3(0.,0.,0.);
	vec3 cameraPos = vec3(radius*sin(rotspeed),10.*iMouse.y/iResolution.y-5.,radius*cos(rotspeed));
	vec3 cameraUp = vec3(0.,1.,0.);
	vec2 uv = fragCoord.xy / iResolution.xy;
	return camera(uv,cameraPos,cameraTarget,cameraUp);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	fragColor = vec4(world(fragCoord),1.);
}