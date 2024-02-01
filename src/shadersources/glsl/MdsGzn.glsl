
#define pi 3.14159265
#define R(p, a) p=cos(a)*p+sin(a)*vec2(p.y, -p.x)
#define hsv(h,s,v) mix(vec3(1.), clamp((abs(fract(h+vec3(1., 1., 3.)/3.)*6.-3.)-1.), 0., 1.), s)*v

float smallBeat, mediumBeat, bigBeat;

float pn(vec3 p) { //noise @Las^Mercury
	vec3 i = floor(p);
	vec4 a = dot(i, vec3(1., 57., 21.)) + vec4(0., 57., 21., 78.);
	vec3 f = cos((p-i)*pi)*(-.5) + .5;
	a = mix(sin(cos(a)*a), sin(cos(1.+a)*(1.+a)), f.x);
	a.xy = mix(a.xz, a.yw, f.y);
	return mix(a.x, a.y, f.z);
}

float fpn(vec3 p) {
	return pn(p*.06125)*.5 + pn(p*.125)*.25 + pn(p*.25)*.125;
}

float field(vec3 hitpoint,float r,float R) {

	if ( sin(iChannelTime[0]) > .5 ) {
		 
		 return (cos( hitpoint.x ) + cos( hitpoint.y ) + cos( hitpoint.z )) + r*1.2;
	
	} else {
		 
		 return length(vec2(length(sin(hitpoint.yz + sin(hitpoint.xy))*cos(hitpoint.yz + cos(hitpoint.yx))+sin(hitpoint.xy)) - r, sin(hitpoint.x) - r)) - R;		//} else if(mediumBeat>0.1) {

	}
	
}
	
float distfunc(vec3 pos) {
	float t = iTime * 0.01;
	vec3 rotpos=mat3(vec3(cos(t*1.63),0.0,-sin(t*1.63)),vec3(0.0,1.0,0.0),vec3(sin(t*1.63),0.0,cos(t*1.63)))*mat3(vec3(cos(t*1.2),-sin(t*1.2),0.0),vec3(sin(t*1.2),cos(t*1.2),0.0),vec3(0.0,0.0,1.0))*(pos-vec3(1.0,1.0,-4.0));
	return field(rotpos,(0.6 * smallBeat)+0.4 + (0.6 * bigBeat),(0.5 * mediumBeat)+0.45 + (0.5 * bigBeat)) + fpn(rotpos*30.+ t*25.) * 0.15;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // create pixel coordinates
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	
	float x = uv.x;
	float y = uv.y;
	
	vec3 ray_dir  = normalize( vec3( x, y, -1.0 ) );
	vec3 ray_orig = vec3( 10.0, 2.0, 0.0 );
	
	float j, w, ld, td= 0.,offs = 0.0;
	vec3 tc = vec3(0.);
				
	
	float fft = texture( iChannel0, vec2(uv.x,1.75) ).x;
	vec3 sync = vec3( fft, 4.0*fft*(1.0-fft), 1.0-fft ) * fft;

	smallBeat  = sync.r * 0.1;
	mediumBeat = sync.g * 0.1;
	bigBeat    = sync.b * 0.1;	
    
	for( float i = 0.0; i < 50.0;i += 1.0 ) {
		
		float dist = distfunc(ray_orig+ray_dir*offs);
		offs+=dist;
			
		if ( abs(dist) < .05 ) {
			 
			 ld = 0.05 - dist;
			 w = (1. - td) * ld;   
			
			 tc = tc + w * hsv(w*3.-0.5, 1.-w*20., 1.); 
			 td = td + w ;	
		}	
		
		td += 1./200.;			
		
		if(abs(dist)<0.0001) break;
		else if(offs>50.0) break;
			
	}
	
	fragColor = vec4(tc + mediumBeat * 0.1, 1.0);
	
}