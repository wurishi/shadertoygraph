#ifdef GL_ES
precision mediump float;
#endif



float hash( float n )
{
	return fract( sin(n)*54671.57391);
}

float noise( vec2 p )
{
	return hash( p.x + p.y * 57.1235 );
}

struct Line{
	vec3 loc;
	vec3 dir;
	vec3 color;
	float t;
	int id_obj;
};
	
struct Material{
	vec3 ambient;
	vec3 difuse;
	vec3 specular;
	float brightness;
	float reflectance;
};
	
struct Sphere{
	vec3 loc;
	Material mat;
	float r;
};

struct Light{
	vec3 loc;
	vec3 color;
};
	
Material gold = Material(vec3(0.24725,0.1995,0.0745),vec3(0.75164,0.60648,0.22648),vec3 (0.628281,0.555802,0.366065),51.2, 0.6);		
Material red   = Material(vec3(0.1,0.0,0.0),vec3(0.6,0.0,0.0),vec3(0.8,0.0,0.0),50.0,0.7);
Material blue  = Material(vec3(0.1,0.1,0.3),vec3(0.0,0.0,0.6),vec3(0.0,0.0,0.8),30.0,0.4);
Material green = Material(vec3(0.1,0.3,0.1),vec3(0.0,0.6,0.0),vec3(0.0,0.8,0.0),70.0,0.0);
Material white = Material(vec3(1),vec3(1),vec3(1),70.0,1.0);
vec3 background_color = vec3(0.8,0.8,0.9);
Sphere sph[4];
Light light = Light(vec3(-5.0,10.0,5.0),vec3(1.0,1.0,1.0));
Light light2 = Light(vec3(-15.0,16.0,-30.0),vec3(1.0,1.0,1.0));
Light lights[2];

void background (inout Line line){
	line.color = background_color;
}

bool sphere_hits(in Line line, out float t, Sphere sphere){
	vec3 p0 = line.loc - sphere.loc;
	vec3 v = line.dir;
	float b = 2.0*dot(p0,v);
	float c = dot(p0,p0) - sphere.r*sphere.r;
	float D = b*b -4.0*c;
	if (D < 0.0) return false;
	if (D == 0.0){
		t = (-b)/2.0;
		return true;
	}
	if (D > 0.0){
		float t0,t1;
		t0 = (-b + sqrt(D))/2.0;
		t1 = (-b - sqrt(D))/2.0;
		if ( t0 < t1 && t0 > 0.0) t = t0;
		else if (t1 < t0 && t1 > 0.0) t = t1;
		else return false;
		return true;
	}
	return false;
}

vec3 sphere_norm(Sphere sphere, vec3 hit_loc){
	return normalize(hit_loc - sphere.loc);
}

vec3 plane_norm(vec3 hit_loc){
	return normalize(vec3(0.0,1.0,0.0));
}

bool plane_hits(in Line line, out float t){
	vec3 n = vec3(0.0,1.0,0.0);
	//t = (0.0 - dot(line.loc,n)/dot(line.dir,n));
	t = - line.loc.y/line.dir.y;
	if (t <= 0.0) return false;
	return true;
}

bool intersect(inout Line line){
	float t_hit = 0.0;
	float best_hit = 0.0;
	int best_obj = -1;
	
	//for each sphere
	for(int i = 0; i < 4; i++){
		//if ray hit with sphere i
		if (sphere_hits(line,t_hit,sph[i])){
			if (t_hit < best_hit || best_obj < 0){
				best_hit = t_hit;
				best_obj = i;
			}
		}
	}
	
	//if ray doesn't hit with any sphere then check if hit with plane
	if (best_obj < 0){
		if (plane_hits(line,t_hit))
			if (t_hit < best_hit || best_obj < 0){
				best_hit = t_hit;
				best_obj = 100;
			}
	}
	
	//check if hit is infront camera
	if (best_obj >= 0){
		line.id_obj = best_obj;
		line.t = best_hit;
		return true;
	}
	
	return false;
}

bool shadowIntersect(inout Line line){
	float t_hit = 0.0;
	
	//for each sphere
	for(int i = 0; i < 4; i++){
		//if ray hit with sphere i
		if (sphere_hits(line,t_hit,sph[i]))
			return true;
	}
	if (plane_hits(line,t_hit)) return true;
	
	return false;
}

vec3 randomRay(vec3 N, vec2 fragCoord){
	while (true) {
		float x = noise(fragCoord.xy);
		float y = noise(fragCoord.xy);
		float z = noise(fragCoord.xy);
		if (x * x + y * y + z * z > 1.0) continue;
		if (dot(vec3(x, y, z), N) < 0.0) continue; // ignore "down" dirs
		return normalize(vec3(x, y, z)); // success!
	}
}

float ambientOcclusion(vec3 Pi, vec3 N, float m, vec2 fragCoord){
	float occlusedRays = 0.0;
	vec3 r;
	Line l;
	for (float i = 0.0; i < m; i+=1.0){
		r = randomRay(N,fragCoord);
		l = Line(Pi+r*0.01,r,vec3(0.0),0.0,-1);
		if(intersect(l))
			if (l.t < 3.0)
				occlusedRays+=1.0-l.t/3.0;
	}
	return (m-occlusedRays)/m;
}

void calculateColor(inout Line line_in, out Line lineR,bool occlusion, vec2 fragCoord){
	vec3 Pi = line_in.loc + line_in.dir*line_in.t;
	vec3 N;
	vec3 Kd,Ks,Ka;
	float gloss;
	if (line_in.id_obj != 100){
		N = sphere_norm(sph[line_in.id_obj],Pi);
		Kd = sph[line_in.id_obj].mat.difuse;
		Ks = sph[line_in.id_obj].mat.specular;
		Ka = sph[line_in.id_obj].mat.ambient;
		gloss = sph[line_in.id_obj].mat.brightness;
		//sph[line.id_obj].mat.reflectance;
	}else{
		N = plane_norm(Pi);
		Kd = vec3(0.7,0.7,0.0);
		Ks = vec3(0.8,0.8,0.0);
		Ka = vec3(0.075,0.075,0.0);
		gloss = 10.0;
	}
	//line_in.color = vec3(1.0);//*ambientOcclusion(Pi,N,64.0);

	vec3 E = -line_in.dir;
	vec3 Er = reflect(line_in.dir,N);
	lineR = Line(Pi+Er*0.01,Er,vec3(0.0,0.0,0.0),0.0,-1);
		
	//foreach light
	for(int i = 0; i < 1; i++){
		vec3 L = lights[i].loc - Pi;
		float d = length(L);
		L = normalize(L);
		Line l = Line(Pi+L*0.01,L,vec3(1.0),0.0,-1);
		
		if (shadowIntersect(l) && !occlusion )
			line_in.color += Ka;
		//	line_in.color += vec3(0.05);
		else{
	
	
		float NdotL  = clamp( dot(N,L), 0.0, 1.0 );
		vec3 diffuse = NdotL*Kd;
//		line.color += diffuse;
		float LdotEr = clamp( dot(L,Er), 0.0, 1.0);
		//celshading
//			if (LdotEr < 0.3) LdotEr = 0.3;
//			else if (LdotEr < 0.65) LdotEr = 0.65;
//			else if (LdotEr < 1.0) LdotEr = .99;
		vec3 specular = pow(LdotEr,gloss)*Ks;
		line_in.color += (diffuse + specular);
		}
	}
	//OCCLUSION
	if (occlusion)
		line_in.color *= vec3(ambientOcclusion(Pi,N,32.0,fragCoord));


}

void trace(inout Line line_trace, vec2 fragCoord){
	Line lineR,aux;
	if (intersect(line_trace)){
		calculateColor(line_trace,lineR,false,fragCoord);
		/*int i = 0;
		while (i < 2){
			if (intersect(lineR)){
				calculateColor(lineR,aux);
				//line_trace.color += vec3(1.0,0.0,0.0);
				line_trace.color += lineR.color;
				lineR = aux;
				i++;
			}else{
				background(lineR);
				line_trace.color += lineR.color*0.1;
				i=2;
			}
		}*/
	}else 
		background(line_trace);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
	sph[0] = Sphere(vec3(-1.0,3.0,1.5),red,3.0);
	sph[1] = Sphere(vec3(1.5,1.0,-1.0),blue,1.0);
	sph[2] = Sphere(vec3(-3.0,1.0,6.0),gold,1.0);
	sph[3] = Sphere(vec3(4.0,3.0,3.0), white,1.0);
	lights[0] = light;
	lights[1] = light2;

	vec2 p = fragCoord.xy/iResolution.xy;
	p = -1.0 + 2.0*p;
	p.x *= iResolution.x/iResolution.y;

//	float x = 0.6;//cos(iTime);	
//	float y = 1.4;//sin(iTime);
	float x = sin(iTime);	
	float y = cos(iTime);

	vec3 lookAt = vec3(0.0, 0.0, 0.0);
	vec3 ro = vec3(x*9.0,6.0,y*9.0); //camera position
	vec3 front = normalize(lookAt - ro);
	vec3 left = normalize(cross(vec3(0,1,0), front));
	vec3 up = normalize(cross(front, left));
	vec3 rd = normalize(front*1.5 + left*p.x + up*p.y); // rect vector
	
	Line ray = Line(ro,rd,vec3(0.0),0.0,-1);		// create ray with (loc,dir,color,distance to hit(0.0 initial), object hitted(no object hitted)) 
	
	trace(ray,fragCoord);
	
	fragColor = vec4(ray.color,1.0);
	
}