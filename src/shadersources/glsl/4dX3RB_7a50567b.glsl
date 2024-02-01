const vec2 Center = vec2(-0.07,-0.09);
const float Zoom = 28.0;
const int Iterations = 128;
const float xoffset_speed = -0.01;

float rand(int t)
{
	return abs(cos(float(t)*123.45));
}

//complex power
vec2 cpow(vec2 a, vec2 b)
{
	float a2 = dot(a,a);
       if (a2 == 0.0) { return vec2(0.0, 0.0); }
	float atn = atan(a.y, a.x);
	float x = pow(a2, (b.x / 2.0)) * exp(-b.y * atn);
	float fi = b.x * atn + b.y / 2.0 * log(a2);
	return vec2(x * cos(fi), x * sin(fi));
}

vec3 color(vec2 c) {
	vec2 z = vec2(0.0,0.0);
	vec2 power = vec2(2.0,0.0);
	float offset = 0.3 + 0.3 * sin(iTime/10.0);
	float speed = 100.0 + 50.0 * cos(iTime/100.0);
	c.x += xoffset_speed * cos(iTime/10.0);
	vec2 cc = vec2(c.y,c.x);
	int i = 0;
	bool iterate = true;
	for (int ii = 0; ii < Iterations; ii++) {
		if(iterate) {
			z = cpow(z, power) + cc;
			float add = sin(offset + float(i) * 2.0 * 3.14159265 / speed);
			power = power + vec2(add,add);
			i = ii;
			if (dot(z,z)> 4.0) iterate = false;
		}
	}
	if (i < Iterations-1) {
		//wave color
		float cr, cg, cb, cmax, cmin;
		iterate = true;
		for (int ii = 0; ii < 10; ii++) {
			if(iterate) {
				cr = rand(i);
				cg = rand(i+1);
				cb = rand(i+2);
				cmax = max(cr, max(cg, cb));
				cmin = min(cr, min(cg, cb));
				if (cmin < 0.125 || ((cmax - cmin) < 0.25 && cmin < 0.78)) {
					i = i + Iterations;
				}
				else {
					iterate = false;
				}
			}
		}
		return vec3( cmin, cmin, cmax );
	}  else {
		//sky
		return vec3(0.26, 0.59, 0.87);
	}
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

	vec2 pixelSize = vec2(1.0 / iResolution.x, 1.0 / iResolution.y);
	vec2 coord = ( fragCoord.xy * pixelSize ) / Zoom + Center;
	vec2 scale = 0.5 * pixelSize / Zoom;
	vec2 c = coord.xy + scale* 2.0;
	
	vec3 col = color(c);
	//col = col + color(vec2(c.x + scale.x, c.y));
	//col = col + color(vec2(c.x, c.y + scale.y));
	//col = col + color(c + scale);
	fragColor = vec4(col / 1.0, 1.0);
}
