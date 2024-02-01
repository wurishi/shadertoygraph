#define PI 			3.1415926
#define N_UFO		9.0

mat3 m = mat3( 0.10,  0.40,  0.60,
               0.80,  -0.76,  0.28,
              -0.20, -0.18,  0.94 );

float hash( float n )
{
    return fract(sin(n)*43758.5453);
}


float noise( in vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);

    f = f*f*(3.0-2.0*f);

    float n = p.x + p.y*57.0 + 113.0*p.z;

    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}

float fbm(in vec3 p) {
	float f = 0.0;
	f += 0.50000*noise(p); p = m*p*1.98;
	f += 0.25000*noise(p); p = m*p*2.03;
	f += 0.12500*noise(p); p = m*p*2.04;
	f += 0.06250*noise(p);
	return f/0.9375;
}


vec4 ufoColor() {
	return vec4(0.0,0.0,1.0,1.0);	
}

vec4 foregroundColor(in vec3 p) {
	float fact = sin(iTime);
	return vec4(0.5+0.5*abs(fact),0.1+0.8*fbm(fact*p),0.1+0.8*fbm(p),1.0);	
}

vec4 backgroundColor(in vec3 p) {
	float r = fbm(15.0*m*p);
	float g = fbm(8.0*m*m*p);
	float b = fbm(11.0*p*p);
	//r = g = b = 1.0;
	return vec4(r,g,b,1.0);	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 p = -1.0+2.0*fragCoord.xy / iResolution.xy;
	p.x *= iResolution.x/iResolution.y;
	float time = iTime;	
	
	float theta = sin(0.3*time);
	mat2 m2 = mat2(cos(theta), -sin(theta),
               	   sin(theta),  cos(theta));
	vec2 p2 = m2*(p-vec2(3.0*sin(0.4*time),3.0*pow(sin(0.41*time),0.5)));
	p += vec2(0.6*sin(3.192*time)*sin(time),0.5*cos(3.2*time)*cos(time));
	p += vec2(-0.6,-0.1);
	float r = sqrt(dot(p,p));
	float a = atan(p.x,p.y);
	
	float radius = (0.6+ 0.05*sin(time*3.0))*(1.0+0.2*sin(6.0*(atan(p.x,p.y)+time)));
	float bg = smoothstep(radius, radius+0.02, r);
	float fg = 1.0-bg;
	float ufos = 0.0;
	
	float vUfo = 1.0;
	float rUfo = 0.1;
	for (float k=0.0; k<N_UFO; k++) {
		vec2 ps = (0.3*sin(time*1.0)+0.5)*radius*vec2(sin(vUfo*time+k*2.0*PI/N_UFO),cos(vUfo*time+k*2.0*PI/N_UFO));
		ufos += 1.0-smoothstep(rUfo, rUfo*1.01, sqrt(dot(p-ps,p-ps)));
		float border = smoothstep(rUfo*1.1, rUfo*1.11, sqrt(dot(p-ps,p-ps)));
		border *= 1.0-smoothstep(rUfo*1.11, rUfo*1.2, sqrt(dot(p-ps,p-ps)));
		ufos += border;
		border = smoothstep(rUfo*1.3, rUfo*1.33, sqrt(dot(p-ps,p-ps)));
		border *= 1.0-smoothstep(rUfo*1.33, rUfo*1.5
								 , sqrt(dot(p-ps,p-ps)));
		ufos += border;
	}
//	vUfo = 2.0;
//	rUfo = 0.01+0.04*pow(sin(time*15.0),2.0);
//	float newRad = 0.3/radius+0.1*cos(15.0*time);
//	for (float k=-0.5; k<3.0*N_UFO; k++) {
//		vec2 ps = (0.3*sin(-time*1.0)+0.5)*newRad*vec2(sin(vUfo*time+k*2.0*PI/(3.0*N_UFO)),cos(vUfo*time+k*2.0*PI/(3.0*N_UFO)));
//		ufos += 0.5-0.5*smoothstep(rUfo, rUfo*1.01, sqrt(dot(p-ps,p-ps)));
//	}
	
	vec4 col = vec4(0.0);
	col += bg*backgroundColor(vec3(p2.xy,noise(vec3(sin(time)*cos(time)*(p2.x-3.0)-cos(time)*p2.y,cos(3.3*time)*p2.y+time/10.0,sin(time/2.0)*(p2.y-0.3)))));
	//col += bg*backgroundColor(vec3(p.xy,noise(vec3(sin(time)*p.y,cos(3.3*time)*p.x,sin(time/2.0)*p.x))));
	col += (fg-ufos)*foregroundColor(vec3(p.xy/(sin(time*3.0)+1.8),0.0))*(1.0-smoothstep(radius*0.9,radius,r));
	col += ufos*ufoColor();
	
	fragColor = col;
}
