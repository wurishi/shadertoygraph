// Copyright (c) 2013 Andrew Baldwin (baldand)
// License = Attribution-NonCommercial-ShareAlike (http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US)

// "Quadric #1"
// Ray traced evolving quadric surface modulated by the audio FFT

const mat4 quadric = mat4(-1.,0.,0.,0.,
						  0.,1.,0.,0.,
						  0.,0.,1.,0.,
						  0.,0.,0.,-.1);

const vec3 up = vec3(0.,1.,0.);
const vec3 boxPos = vec3(0.,0.,0.);

void intersectbox(vec3 ro, vec3 rd, vec3 A, vec3 B, out float t0, out float t1)
{
    vec3 ir = 1.0/rd;
    vec3 tb = ir * (A-ro);
    vec3 tt = ir * (B-ro);
    vec3 tn = min(tt, tb);
    vec3 tx = max(tt, tb);
    vec2 t = max(tn.xx, tn.yz);
    t0 = max(t.x, t.y);
    t = min(tx.xx, tx.yz);
    t1 = min(t.x, t.y);
}

float intersect(vec3 ro, vec3 rd, out vec3 i, float scale)
{
	float tb0,tb1;
	intersectbox(ro,rd,vec3(-scale),vec3(scale),tb0,tb1);
	float inbox = tb1-tb0;
	if (inbox<0.0) return inbox;
	i = ro + tb0*rd;
	tb1 -= tb0;
	mat4 sq = quadric;
	sq[0][0] = mix(-1.,1.,sin(iTime*.15));
	sq[1][1] = mix(-1.,1.,sin(iTime*.43));
	sq[2][2] = mix(-1.,1.,sin(iTime*.71));
	sq[3][3] = mix(.0,-1.,sin(iTime*.93));
	float fftx = 0.0;
	float fftxstep = 1./16.;
	for (int x=0;x<4;x++) {
		for (int y=0;y<4;y++) {
			sq[x][y] += 1.*texture(iChannel0,vec2(fftx,0.25)).x-.5;
			fftx += fftxstep;
		}
	}
	vec4 C = vec4(i,1.);
	vec4 AC = sq * C;
	vec4 D = vec4(rd,0.);
	vec4 AD = sq * D;
    float a = dot(D,AD); 
    float b = dot(C,AD) + dot(D,AC);
	float c = dot(C,AC);
    float d = b*b - 4.0*a*c;
	if (d>=0.0) {
	    float ds = sqrt(d);
    	float t0 = ((-b + ds)/(2.0*a));
    	float t1 = ((-b - ds)/(2.0*a));
    	float tx = max(t1,t0);
    	float tn = min(t1,t0);
		if (tn<0.) tn=tx;
		if (tn<0.) { d=-0.01; tn=tb1;}
		if (tn>tb1) { d=-0.01; tn=tb1;}
		i = (C + tn * D).xyz;
	}
	return d;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float radius = sin(iTime*.1)*2.+4.;
	vec3 eye = vec3(radius*sin(iTime),1.*sin(.1*iTime),radius*cos(iTime));
	vec3 screen = vec3((radius-1.)*sin(iTime),.5*sin(.1*iTime),(radius-1.)*cos(iTime));
    vec2 screenSize = vec2(iResolution.x/iResolution.y,1.0);
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 offset = screenSize * (uv - 0.5);
	vec3 right = cross(up,normalize(screen - eye));
	vec3 ro = screen + offset.y*up + offset.x*right;
	vec3 rd = normalize(ro - eye);
	vec3 i = vec3(0.);
	float d = intersect(ro-boxPos,rd,i,radius*.5);
	float w = texture(iChannel0,vec2(fract(.1*(i.z+i.x+i.y)),0.25)).x;
	fragColor = vec4(step(0.,d)*vec3(w)*vec3(abs(i)),1.0);
}