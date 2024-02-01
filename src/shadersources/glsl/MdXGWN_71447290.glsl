/*
  Andor Salga
  June 2013
*/

vec3 getNormal(in vec2 sphereCenter, in float sphereRadius, in vec2 point){
	// Need to figure out how far the current point is from the center to lerp it
	float distFromCenter = distance(point, sphereCenter);
	float weight = distFromCenter/sphereRadius;
	
	// Z component is zero since at the edge the normal will be on the XY plane
	vec3 edgeNormal = vec3(point - sphereCenter, 0);
	edgeNormal = normalize(edgeNormal);
	
	// We know the normal at the center of the sphere points directly at the viewer,
	// so we can use that in our mix/lerp.
	return mix(vec3(0,0,1), edgeNormal, weight); 
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec2 center = vec2(iResolution.xy)/2.0;
	
	vec2 spherePos = vec2( sin(iTime), cos(iTime)) * 30.0;
	
	if( distance(center + spherePos, vec2(fragCoord)) < 100.0){
		vec3 sphereNormal =  vec3(getNormal(center, 100.0, vec2(fragCoord)));
		vec3 dirLight = vec3(0,0,0.81);
		vec3 col =  normalize((vec3(1,1,1))) * dot(sphereNormal, dirLight);
		fragColor = vec4(0.1) + vec4(col, 1);
	}
	else{
		fragColor = vec4(0);
	}
}