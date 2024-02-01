
/*
* GLSL HSV to RGB+A conversion. Useful for many effects and shader debugging.
*
* Copyright (c) 2012 Corey Tabaka
*
* Hue is in the range [0.0, 1.0] instead of degrees or radians.
* Alpha is simply passed through for convenience.
*/
 
vec4 hsv_to_rgb(float h, float s, float v, float a)
{
	float c = v * s;
	h = mod((h * 6.0), 6.0);
	float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
	vec4 color;
 
	if (0.0 <= h && h < 1.0) {
		color = vec4(c, x, 0.0, a);
	} else if (1.0 <= h && h < 2.0) {
		color = vec4(x, c, 0.0, a);
	} else if (2.0 <= h && h < 3.0) {
		color = vec4(0.0, c, x, a);
	} else if (3.0 <= h && h < 4.0) {
		color = vec4(0.0, x, c, a);
	} else if (4.0 <= h && h < 5.0) {
		color = vec4(x, 0.0, c, a);
	} else if (5.0 <= h && h < 6.0) {
		color = vec4(c, 0.0, x, a);
	} else {
		color = vec4(0.0, 0.0, 0.0, a);
		
		color.rgb += v - c;
 
		return color;
	}
 

	color.rgb += v - c;
 
	return color;
}

/*
* Copyright (C) 2013 Martin Shirokov
*
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
* associated documentation files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
* and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all copies or substantial
* portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
* LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

const float MIN = 0.01;
const vec3 MINX = vec3(MIN, 0., 0.);
const vec3 MINY = vec3(0., MIN, 0.);
const vec3 MINZ = vec3(0., 0., MIN);
const float MAX = 10.0;
const int I = 50;
const int SHAPES = 20;
const int MAX_B = 5;
const float PI = 3.1415926535;
const float TWO_PI = 2. * PI;

float sphere(vec3 p, vec3 c, float r){
	
	return distance(p, c) - r;
}

float map(vec3 p){
	float dist = MAX;
	
	for(int i = 0; i < SHAPES; i++){
		float ang2 = float(i) / float(SHAPES) * TWO_PI;
		float ang = ang2 + cos(2.824 + sin(iTime)) + iTime / 5.;
		dist = min(dist, sphere(p, vec3(sin(ang)*5., cos(1.243 + sin(iTime + ang2*5.)), cos(ang)*5.), 0.5));
	}
	
	return dist;
}

vec3 ray(vec3 p, vec3 d){
	
	float dist = 1.0;
	
	for(int i = 0; i < I; i++){
		
		if(dist < MIN)
			return p;
		if(length(p) > MAX)
			return p;
		dist = map(p);
		p += d * dist;
	}
	return vec3(0.0);
}

vec3 cam(vec2 uv){

	return normalize(vec3(uv, 1));
}

vec3 normal(vec3 p){

	vec3 n = vec3(0.);
	n.x = map(p + MINX) - map(p - MINX);
	n.y = map(p + MINY) - map(p - MINY);
	n.z = map(p + MINZ) - map(p - MINZ);
	
	return normalize(n);
}


vec4 color(vec3 p){
	
	return hsv_to_rgb(sin(atan(p.x/p.z)) + cos(2.824 + sin(iTime)) + iTime / 5., (1. - p.y) * 0.5, 1.0, 1.0);	
}

vec4 render(vec3 p, vec3 d){
	vec4 c = vec4(1.);
	for(int i = 0; i < MAX_B; i++){
		p = ray(p, d);
	
		if(length(p) > MAX)
			return c*texture(iChannel0, d);
		vec3 n = normal(p);
		d = n;
		c *= color(p);
		p += d * MIN;
		
	}
	return vec4(0.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	
	vec2 uv = fragCoord.xy / iResolution.y;
	vec2 m = (iMouse.xy / iResolution.xy * vec2(1.0, -1.) + vec2(0., 0.5)) * PI;
	m.x *= 3.;
	m.x *= 3.;
	if(iTime < 5.) // For the thumbnail
		m = vec2(0.5);
	uv.x -= iResolution.x / iResolution.y / 4.0;
	mat3 r, rx, ry;
	
	float sx, cx, sy, cy;
	
	sx = sin(m.x);
	sy = sin(m.y);
	cx = cos(m.x);
	cy = cos(m.y);
	
	ry = mat3(
			cx,	0,	sx,
			0,	1,	0,
			-sx,0,	cx);
		
	rx = mat3(
			1,	0,	0,
			0,	cy,	-sy,
			0,	sy,	cy);
	r = rx * ry;
	
	vec3 d = cam(uv)*r;
	fragColor = render(vec3(0.), d);
}