
vec3 cam;

int cnt = 0;
vec2 z = vec2(0.0, 0.0);
float inst_zoom;

vec2 fragCoord;
vec4 fragColor;

vec2 project() {
	// deal with our scaling and zooming
	vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
    p.x *= iResolution.x/iResolution.y; // this replaces the 3, 2 coeffs
	p = cam.xy + pow(cam.z, 5.0)*p;
	return p;
}

void circ(vec2 center, float limit, float radius, float thickness) {
	// by far the easiest - not disjoint!
	vec2 p = project();
	vec3 c = vec3(center.x, center.y, radius*pow(cam.z, 4.0));
	if(cam.z < limit) c.z = (radius*pow(limit, 10.0))/pow(cam.z, 6.0);
	if((pow((p.x-c.x), 2.0) + pow((p.y - c.y), 2.0) > pow(c.z, 2.0)) && // collide a circle
	   (pow((p.x-c.x), 2.0) + pow((p.y - c.y), 2.0) < pow((c.z+thickness*c.z), 2.0))) { // and a slightly bigger one to grab the ring
		fragColor = vec4(.25, .8, .5, 1.0);
	}
}

void rect(vec4 desc, float limit, float stretch, float thickness) {
	// desc = center, w, h
	vec2 p = project();

	if(cam.z < limit)
		inst_zoom = (stretch*pow(limit, 10.0))/pow(cam.z, 6.0);
	else
		inst_zoom = stretch*pow(cam.z, 4.0);
	
	desc.zw *= inst_zoom;

	if(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && // collide against a big rect
	   p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0)) {
		desc.zw *= (1.0-thickness); // scale it down
		if(!(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && // and try again so we catch the "border"
			 p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0))) {
			fragColor = vec4(.25, .8, .5, 1.0);
		}
	}
}

void diamond(vec4 desc, float limit, float stretch, float thickness) {
	// desc = center, w, h
	vec2 p = project();
	float theta = degrees(pow(cam.z, 1.0));  // don't be mislead, theta is actually radians

	vec2 tmp = p;
	p.x = (tmp.x-desc.x)*cos(theta) - (tmp.y-desc.y)*sin(theta) + desc.x;
	p.y = (tmp.x-desc.x)*sin(theta) + (tmp.y-desc.y)*cos(theta) + desc.y;
	
	if(cam.z < limit)
		inst_zoom = (stretch*pow(limit, 10.0))/pow(cam.z, 6.0);
	else
		inst_zoom = stretch*pow(cam.z, 4.0);
	desc.zw *= inst_zoom;
	if(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && // collide with the bigger rect
	   p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0)) {
		desc.zw *= (1.0-thickness); // shrink the inner rect by this much
		if(!(p.x > (desc.x - desc.z/2.0) && p.x < (desc.x + desc.z/2.0) && p.y > (desc.y - desc.w/2.0) && p.y < (desc.y + desc.w/2.0))) {
			// and then color it if we're in the area between the two
			// note the negation!
			fragColor = vec4(.25, .8, .5, 1.0);
		}
	}
}

void mainImage( out vec4 oFragColor, in vec2 iFragCoord )
{
    cam = vec3(-0.08896, 0.65405, clamp(1.0/iTime, 0.0, 1.0));;
        
    fragCoord = iFragCoord;
	vec2 p = project();

	// 100 orbits, we hit floating point resolution before that anyways
	for (int i = 0; i < 100; ++i){
		if (z.x*z.x + z.y*z.y <= 4.0) { // values greater than 2 proven to escape - optimization courtesy of the internet
			z = vec2(z.x*z.x - z.y*z.y + p.x, z.r*z.y+z.y*z.r + p.y);
			cnt++;
		} else {
			break;
		}
	}

	// 100 = still inside! Paint it black.
    if(cnt==100) {
    	fragColor = vec4(0.0, 0.0, 0.0, 1.0);
    } else { 
    	// otherwise something cooler.
		float col = (mod(float(cnt)+iTime*9.0,10.0)/10.0);
		float col2 = (mod(float(cnt)+iTime*2.0,10.0)/10.0);
		fragColor = vec4((col2+col2)/2.0, (col+col2)/2.0, col+.2, 1.1);
	}
	

	// these calls are where things get interesting. They add a shape to mark a region of interest.
	// I developed these myself through trial and error with pen, paper, and time.
	// The most important part is how it changes scaling functions after a threshhold zoom level is reached so you fly through the shape.
	// For this to work, the two scaling functions have to match up at the point where they overlap.
	// originally, this was achieved like so:
    
	//if(cam.z < limit) inst_zoom = (stretch*pow(limit, 4.0))/(pow(limit, 4.0-(acc*(1.0/limit))))*pow(cam.z, 4.0-(acc*(1.0/limit)));
	//else inst_zoom = stretch*pow(cam.z, 4.0);
	
	//, where acc is limit / .1
	// If I plug these eqations into a CAS, they're reduced to: scale*limit^10 / zoom^6
	// so, for everyone's sake, I'm going to put those into the code here, even though you lose the ability to set the ease-out acceleration on a per-shape basis.
	// This makes it /just/ scoot out before you see it stop

	vec2 center = vec2(-.745, 0.186);
	circ(center, .25, .1, .08);
	
	center = vec2(-1.74981, 0.0);
	diamond(vec4(center, 1.0, 1.0), .17, .2, .08);
	
	center = vec2(-0.08896, 0.65405);
	rect(vec4(center, 1.0, 1.0), .2, .2, .08);
	oFragColor = fragColor;
	}