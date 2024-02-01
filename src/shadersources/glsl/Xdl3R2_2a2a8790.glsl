vec2 resolution;
float time;


vec2 local_coords(vec2 q) {
	vec2 r = -1.0 + 2.0 * q / resolution.xy;
	r.x *= resolution.x/resolution.y;
	return r;
}

float negmod(float x, float y) {
	return mod(x + y, y + y) - y;
}

//cylinder distance map
float cylinder_dist(vec3 q) {
	vec3 qp;
	q.z += 0.3 * sin(q.y + q.x);
	q.x += 0.3 * cos(q.y + q.x);
	qp.x = negmod(q.x, 2.0);
	qp.y = negmod(q.y, 2.0);
	qp.z = (q.z > 0.) ? negmod(q.z, 2.0) : q.z;
 
  return length(qp.xz)- 0.1 + max(0.01 * (q.y + 5.0 * sin(q.z + q.x)), 0.0);
}

//sphere distance map
float sphere_dist(vec3 q) {
	vec3 qp;
	q.x += 0.5 * cos(q.z * 0.1) + 0.5 * sin(q.x * 0.1) + 0.3 * sin(q.y + q.x);
    q.y += 0.5 * sin(q.z) + 0.5 * cos(q.x);
    q.z += 0.5 * sin(q.y * 0.1) + 0.5 * cos(q.x * 0.1) + 0.3 * cos(q.y + q.x);
	qp.x = negmod(q.x, 2.0);
	qp.y = negmod(q.y, 2.0);
	qp.z = (q.z > 0.) ? negmod(q.z, 2.0) : q.z;
	return length(qp) - 1.0
		+  0.1 * sin(q.x * 5.0 + 2.0 * q.z + 3.0 * q.y + time)
		+ 0.1 * cos(q.x * 2.3 + 4.1 * q.z + 1.8 * q.y + time*1.7)
		 + max(0.1 * (q.y + 5.0 * sin(q.z + q.x) + 1.0), 0.0);
}

vec3 scene_color(vec3 q) {
	if (sphere_dist(q) < cylinder_dist(q))
		return vec3(  0.1 * cos(1.5*q + time) + 0.7);

	vec2 qp;
	q.z += 0.3 * sin(q.y + q.x);
	q.x += 0.3 * cos(q.y + q.x);
	qp.x = negmod(q.x, 2.0);
	qp.y = (q.z > 0.) ? negmod(q.z, 2.0) : q.z;
	return vec3(dot(normalize(qp), vec2(0.5, -1.0))*0.2);
}

//scene render
float scene(vec3 q) {
	return min(sphere_dist(q), cylinder_dist(q));
}

vec3 path(float time) {
	vec3 p;
	p.x = 0.3 * cos(time) + 5.0 * cos(time * 0.2 + 9.8) + 10.0 * cos(time * 0.1 + 3.4) + 2.0;
	p.y = 0.25 * cos(time * 0.5) + 6.0 * cos(time * 0.3 + 3.4) + 9.0 * cos(time * 0.15 + 1.0) + 1.0;
	p.z = time;
	return p;
}

//main loop
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
resolution = iResolution.xy;
time = iTime;
	//convert screenspace to local space, preserving aspect ratio
	vec2 p = local_coords(fragCoord.xy);

	vec3 origin, track, dir;
	
	//set camera point
	origin = path(time);
	track = path(time + 1.0) + vec3(0.0, -0.1, 0.0);
	dir = normalize(track - origin);
	
	vec3 up = normalize(vec3(dir.x, 1.0, dir.z));

	vec3 rvec = normalize(cross(up, dir));
	vec3 uvec = normalize(cross(dir, rvec));

	//calculate projection ray
	vec3 ray = normalize(rvec * p.x + uvec * p.y + dir);

	vec3 q = origin;
 	vec3 intr;

 	float d = 0.0, t = 0.0;
bool gave=  false;

 	for(int i = 0;(i < 85); i++)
	 {
	  d = scene(q) * 0.65;
	  q += d * ray;
	  t += d;
	 }
	 intr = q;

 	float fog = smoothstep(20.0, 40.0, t);
vec3 sky = vec3(0.05) + abs(ray.y+1.0)*vec3(0.0,0.03,0.15);
float sunprod = max(dot(ray, vec3(0.33,0.67,0.67)),0.0);
vec3 sun =  vec3(0.8) * smoothstep(0.97, 0.99, sunprod) + vec3(0.05, 0.1, 0.1) * sunprod ;

	vec3 col = mix(scene_color(intr),sky+sun, fog);
if (gave) col = vec3( 1.0,0.0,0.0);
 	fragColor= vec4(col,1.0);
 }
