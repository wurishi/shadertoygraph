// Created by Nikita Miropolskiy, nikat/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License

#define AA

vec2 rotate2(vec2 p, float theta) {
	return vec2(
		p.x*cos(theta)-p.y*sin(theta),
		p.x*sin(theta)+p.y*cos(theta)
	);
}

float scene(vec3 p) {
	p.xz = rotate2(p.xz, iTime);
	return length(p)-1.0+0.04*sin(10.0*(p.x+p.y+0.5*iTime));
}

float raymarche(vec3 origin, vec3 ray, float min_distance, float max_distance) {
	float distance_marched = min_distance;
	for (int i=0; i<160; i++) {
		float step_distance = scene(origin + ray*distance_marched);
		if (abs(step_distance) < 0.001) {
			return distance_marched/(max_distance-min_distance);
		}
		distance_marched += step_distance;
		if (distance_marched > max_distance) {
			return -1.0;
		}
	}
	return -1.0;
}

vec3 render(vec2 q) {
	vec3 eye = vec3(0.0, 0.0, -3.0);
	vec3 screen = vec3(q, -2.0);
	vec3 ray = normalize(screen - eye);

	float s = raymarche(eye, ray, 1.0, 4.0);
	
	vec3 col;
	
	if (s == -1.0) {
		col = vec3(0.5 + 0.5*q.y + 0.08*cos(3.0*q.x));
	} else {
		col = vec3(s*0.75);
		col.rg *= 0.8;
	}
	
	return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 q = (2.0*fragCoord.xy - iResolution.xy)/iResolution.x;
	
	vec3 col = render(q);
	
	#ifdef AA
	vec3 halfpixel = vec3(.5/iResolution.xy, 0.0);
	col += render(q + halfpixel.xz);
	col += render(q + halfpixel.zy);
	col += render(q + halfpixel.xy);
	col *= .25;
	#endif
		
	fragColor = vec4(col, 1.0);
}
