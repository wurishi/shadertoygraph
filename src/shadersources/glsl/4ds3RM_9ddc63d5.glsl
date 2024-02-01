
vec3 cam;

int cnt = 0;
vec2 z = vec2(0.0, 0.0);

vec2 fragCoord;
vec4 fragColor;
void circ(vec2 center, float limit, float radius, float thickness) {
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    p.x *= iResolution.x/iResolution.y; // this replaces the 3, 2 coeffs
	p = cam.xy + pow(cam.z, 5.0)*p;
	float acc = limit / .1;
	vec3 c = vec3(center.x, center.y, radius*pow(cam.z, 4.0));
	if(cam.z < limit) c.z = (radius*pow(limit, 4.0))/(pow(limit, 4.0-(acc*(1.0/limit))))*pow(cam.z, 4.0-(acc*(1.0/limit)));
	if((pow((p.x-c.x), 2.0) + pow((p.y - c.y), 2.0) > pow(c.z, 2.0)) && (pow((p.x-c.x), 2.0) + pow((p.y - c.y), 2.0) < pow((c.z+thickness*c.z), 2.0))) {
		fragColor = vec4(.25, .8, .5, 1.0);
	}
}

void rect(vec4 desc, float limit, float stretch, float thickness) {
	// desc = center, w, h
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    p.x *= iResolution.x/iResolution.y; // this replaces the 3, 2 coeffs
	p = cam.xy + pow(cam.z, 5.0)*p;
	float acc = limit / .1;
	float z = stretch*pow(cam.z, 4.0);
	if(cam.z < limit) z = (stretch*pow(limit, 4.0))/(pow(limit, 4.0-(acc*(1.0/limit))))*pow(cam.z, 4.0-(acc*(1.0/limit)));
	desc.zw = desc.zw * z;
	if(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0)) {
		desc.zw = desc.zw*(1.0-thickness);
		if(!(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0))) {
			fragColor = vec4(.25, .8, .5, 1.0);
		}
	}
}

void diamond(vec4 desc, float limit, float stretch, float thickness) {
	// desc = center, w, h
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    p.x *= iResolution.x/iResolution.y; // this replaces the 3, 2 coeffs
	p = cam.xy + pow(cam.z, 5.0)*p;
	float z = stretch*pow(cam.z, 4.0);

	float theta = degrees(pow(cam.z, 1.0));

	vec2 tmp = p;
	p.x = (tmp.x-desc.x)*cos(theta) - (tmp.y-desc.y)*sin(theta) + desc.x;
	p.y = (tmp.x-desc.x)*sin(theta) + (tmp.y-desc.y)*cos(theta) + desc.y;
	
	tmp = desc.xy;
	//desc.x = tmp.x*cos(theta) - tmp.y*sin(theta);
	//desc.y = tmp.x*sin(theta) + tmp.y*cos(theta);
	
	tmp = desc.zw;
	//desc.z = tmp.x*cos(theta) - tmp.y*sin(theta);
	//desc.w = tmp.x*sin(theta) + tmp.y*cos(theta);
	
	
	float acc = limit / .1;
	if(cam.z < limit) z = (stretch*pow(limit, 4.0))/(pow(limit, 4.0-(acc*(1.0/limit))))*pow(cam.z, 4.0-(acc*(1.0/limit)));
	desc.zw = desc.zw * z;
	if(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0)) {
		desc.zw = desc.zw*(1.0-thickness);
		if(!(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0))) {
			fragColor = vec4(.25, .8, .5, 1.0);
		}
	}
}

//	if(p.x <= ((desc.x+desc.z)/2.0) && p.x >= (desc.x) && p.y <= (desc.y) && p.y >= (desc.y-desc.w/2.0)) {

void mainImage( out vec4 oFragColor, in vec2 iFragCoord ) {
    cam  = vec3(-1.74981, .0, clamp(1.0/iTime, 0.0, 1.0));;
    fragCoord = iFragCoord;
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    p.x *= iResolution.x/iResolution.y; // this replaces the 3, 2 coeffs
	p = cam.xy + pow(cam.z, 5.0)*p;
	
	for (int i = 0; i < 100; ++i){
		if (z.x*z.x + z.y*z.y <= 4.0) {
			z = vec2(z.x*z.x - z.y*z.y + p.x, z.r*z.y+z.y*z.r + p.y);
			cnt++;
		} else { break; }
}
        if(cnt==100) { fragColor = vec4(0.0, 0.0, 0.0, 1.0); } else { 
			float col = (mod(float(cnt)+iTime*9.0,10.0)/10.0);
			float col2 = (mod(float(cnt)+iTime*2.0,10.0)/10.0);
			fragColor = vec4((col2+col2)/2.0, (col+col2)/2.0, col+.2, 1.1);
		}
	
	vec2 center = vec2(-.745, 0.186);
	circ(center, .25, .1, .08);
	
	center = vec2(-1.74981, 0.0);
	diamond(vec4(center, 1.0, 1.0), .17, .2, .08);
	
	center = vec2(-0.088, 0.654);
	rect(vec4(center, 1.0, 1.0), .17, .2, .08);
	oFragColor = fragColor;
	}