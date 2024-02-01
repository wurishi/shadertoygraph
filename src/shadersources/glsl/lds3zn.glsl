//My first attempt to raytracing.
//Done following the live by IÃ±igo Quilez stream at http://youtu.be/9g8CdctxmeU
//Thanks a lot for sharing your knowledge.

//Light setup
vec3 light;
//vec3 light = vec3(1.0 + iMouse.x, iMouse.y, -4.0);
float light_range = 10.0;

float shadow_factor = 1.0;

//Object setup
vec4 sph1 = vec4( 0.0, 1.0, 0.0, 1.0);
vec4 sph2 = vec4( 2.0, 1.5, -1.0, 1.5);
//Functions 

float iSphere(in vec3 ro, in vec3 rd, in vec4 sph)
{
	//sphere at origin has equation |xyz| = r
	//sp |xyz|^2 = r^2.
	//Since |xyz| = ro + t*rd (where t is the parameter to move along the ray),
	//we have ro^2 + 2*ro*rd*t + t^2 - r2. This is a quadratic equation, so:
	vec3 oc = ro - sph.xyz; //distance ray origin - sphere center
	
	float b = 2.0 * dot(oc, rd);
	float c = dot(oc, oc) - sph.w * sph.w; //sph.w is radius
	float h = b*b - 4.0 * c; //Commonly known as delta. The term a is 1 so is not included.
	if(h < 0.0) 
		return -1.0;
	float t = (-b - sqrt(h)) / 2.0; //Again a = 1.

	return t;
}

//Get sphere normal.
vec3 nSphere(in vec3 pos, in vec4 sph )
{
	return (pos - sph.xyz)/sph.w;
}

//Intersection with plane.
float iPlane(in vec3 ro, in vec3 rd)
{
	
	
	//Plane equation, y = 0 = ro.y + t * rd.y;
	float t = (-ro.y / rd.y);
	return t;
}

//Get plane normal.
vec3 nPlane(in vec3 pos)
{
	return vec3(0.0, 1.0, 0.0);
}

//Check if the pixel is in shadow.
void inShadow(in vec3 hitpoint)
{
	float resT = 1000.0;
	
	vec3 rd = normalize(light - hitpoint);
	
	float tsph1 = iSphere(hitpoint, rd, sph1);
	float tsph2 = iSphere(hitpoint, rd, sph2); //Invisible sphere casting shadow
	float tpla = iPlane(hitpoint , rd); //Intersect with a plane.
	
	float sph1shdw = 1.0;
	float sph2shdw = 1.0;
	if(tsph1 > 0.001 && tsph1 < resT)
	{
		//vec3 occluder = hitpoint + tsph * rd;
		sph1shdw = smoothstep(0.2, 1.0, smoothstep(0.0, 20.0,length(light - hitpoint)));
		//shadow_factor = max(0.2, 2.0 * length(light - hitpoint) / length(occluder - hitpoint));
	}
	if(tsph2 > 0.001 && tsph2 < resT)
	{
		sph2shdw = smoothstep(0.0, 1.0, smoothstep(0.0, 20.0, length(light - hitpoint) * 0.6));
		//vec3 occluder = hitpoint + tsph * rd;
		//shadow_factor = smoothstep(0.2, shadow_factor,  smoothstep(0.0, 20.0, length(light - hitpoint)));
		//shadow_factor = max(0.2, 2.0 * length(light - hitpoint) / length(occluder - hitpoint));
	}
	if(tpla > 0.5 && tpla < resT)
	{
		//vec3 occluder = hitpoint + tsph * rd;
		//shadow_factor = smoothstep(0.0, 20.0, length(light - hitpoint)) * 0.6;
	}
	
	shadow_factor = min(shadow_factor, min(sph1shdw, sph2shdw));
}

float intersect(in vec3 ro, in vec3 rd, out float resT)
{
	resT = 1000.0;
	float id = -1.0;
	float tsph = iSphere(ro, rd, sph1); //Intersect with a sphere.
	float tsph2 = iSphere(ro, rd, sph2); //Intersect with a sphere.
	float tpla = iPlane(ro , rd); //Intersect with a plane.
	
	if(tsph > 0.0)
	{
		id = 1.0;
		resT = tsph;
		//inShadow(ro + resT * rd);
	}
	if(tsph2 > 0.0 && tsph2 < resT)
	{
		id = 3.0;
		resT = tsph2;
		//inShadow(ro + resT * rd);
	}
	if(tpla > 0.0 && tpla < resT)
	{
		id = 2.0;
		resT = tpla;
		
	}
	inShadow(ro + resT * rd);
	return id;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	light = vec3(cos(iTime) * 5.0, 5.0 + cos(iTime) * 2.0, 5.0);//normalize( vec3(0.57703));

	
	//pixel coordinates from 0 to 1
	vec2 uv = (fragCoord.xy / iResolution.xy);
	
	//Move the sphere
	sph1.x = 0.5 * cos(iTime * 10.0) * texture(iChannel1, mod(vec2(iChannelTime[1]), 1.0)).x;
	//sph1.z = 0.5 * sin(iTime)* texture(iChannel1, mod(vec2(iChannelTime[1]), 1.0)).y;
	
	//generate a ray with origin ro and direction rd
	vec3 ro = vec3(0.0, 0.5, 3.0);
	vec3 rd = normalize(vec3( (-1.0+2.0*uv) * vec2(1.78, 1.0), -1.0));

	//intersect the ray with scene
	float t;
	float id = intersect(ro, rd, t);
	
	vec3 col = vec3(0.7); 
	//Need some lighting and, so, normals.
	if(id > 0.5 && id < 1.5)
	{
		//If we hit the spehere
		vec3 pos = ro + t*rd;
		vec3 nor = nSphere(pos, sph1);
		float dif = max(0.0, dot(nor, normalize(light - pos))); //diffuse.
		
		float attenuation = 1.0 - smoothstep(0.0, light_range, length(light - pos));
		dif *= attenuation;
		
		float ao = 0.5 + 0.5 * nor.y;
		//ao = 0.5 * (dot(nor, nPlane(pos)) + 1.0); complete formula. The one above is simplified.
		col = vec3(0.9, 0.8, 0.6) * dif * ao + vec3(0.1, 0.2, 0.4) * ao;
	}
	else if(id > 1.5 && id < 2.5)
	{
		//If we hit the plame
		//t += clamp(-1.0, 0.0, 0.2 + 0.8 * cos(iChannelTime[1])) + uv.x + uv.y * 2.0 + cos(iTime);
		vec3 pos = ro + t * rd;
		vec3 nor = nPlane( pos );
		//float dif = max(0.0, dot(nor, light));
		
		float amb = min(smoothstep( 0.0, 2.0 * sph1.w, length(pos.xz - sph1.xz) ),
						smoothstep( 0.0, 2.0 * sph2.w, length(pos.xz - sph2.xz) ));
		col = vec3(amb * 0.7  * texture(iChannel0, mod(vec3(ro + rd * t).xz, 0.0) + vec2(cos(iTime), iTime)).xyz);
	}
	else if(id > 2.5)
	{
		//If we hit the spehere
		vec3 pos = ro + t*rd;
		vec3 nor = nSphere(pos, sph1);
		float dif = max(0.0, dot(nor, normalize(light - pos))); //diffuse.
		
		float attenuation = 1.0 - smoothstep(0.0, light_range, length(light - pos));
		dif *= attenuation;
		
		float ao = 0.5 + 0.5 * nor.y;
		//ao = 0.5 * (dot(nor, nPlane(pos)) + 1.0); complete formula. The one above is simplified.
		col = vec3(0.7, 0.5, 0.8) * dif * ao + vec3(0.1, 0.2, 0.4) * ao;
	}
	col *= shadow_factor;
	
	col = sqrt(col);
	
	fragColor = vec4(col,1.0);
}