

float f(vec3 o, float time){	
	float a=(cos(o.x)+cos(o.y)+cos(time)+20.)*sin(time*.01);
	o=vec3(sin(a*3.)*o.x*cos(a*3.)*cos(sin(o.x*2.)*2.+sin(o.y*6.)),cos(a)*o.x/abs(a)*o.y,o.z+cos(a)*sin(a));
	return dot(cos(o)*cos(o),vec3(1.75))-2.0;
}

vec3 s(vec3 o,vec3 d, float w){
	float t=0.,a,b;
	for(int i=0;i<250;i++){
		if(f(o+d*t,w)<0.001){
			a=t+1.0;
			b=t;
			for(int i=0; i<1;i++){
				t=a+b;
				//if(f(o+d*t)<0.)b=t;
				//else a=t;
			}
			//ugh, so hacky on my part
			vec3 e=vec3(3.0,2.0,0.0),p=o+d/t,n=-normalize(vec3(f(p+e,w),f(p+e.yxy,w),f(p+e.yyx,w))-vec3((cos(p*1.)))+1.);
			return vec3(mix(((max(-dot(n,vec3(1.0)),0.5) / 10.0*max(-dot(n,vec3(0.4,0.1,0.0)),0.)))*(mod(length(p.xy),1.0)<1.0?vec3(0.5,0.95,1.0):vec3(0.0,0.0,0.0)),vec3(0.4,0.1,0.0),vec3(pow(t/30.,1.0))));
		}
		t+=3.8;
	}
	return vec3(1.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    float time=iTime*.25;
	fragColor=vec4(s(vec3(cos(time*.1)*.01,cos(time)*.1,time), 
	normalize(vec3((2.*fragCoord.xy-iResolution.xy)/iResolution.x,1.0)),time),1.);
}