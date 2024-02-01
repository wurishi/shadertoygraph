const int MAX_ITERATION = 128;
const float DELTA = 0.4;
const float PI = 3.1415926535897932384626433832795;


const float START_HUE = 0.0;
const float END_HUE   = 0.25;
const float START_SAT = 1.0;
const float END_SAT   = -0.4;


float wrap (float value,float limit) {
	float result = mod(value,limit);
	if (result < 0.0) {result += limit;}
	return result;
}

float hue2channel(float p, float q, float hue) {
	hue = wrap(hue,1.0);
	if(hue < 1.0/6.0) return p + (q - p) * 6.0 * hue;
	if(hue < 1.0/2.0) return q;
	if(hue < 2.0/3.0) return p + (q - p) * (2.0/3.0 - hue) * 6.0;
	return p;	
}


vec4 hslToRgb(vec4 hsl){

	// hue is x
	// saturation is y
	// lightness is z
	hsl.x = wrap(hsl.x,1.0);
	
	vec3 rgb;
	
	if(hsl.y == 0.0){
		rgb.xyz = hsl.zzz; // achromatic
	} else {
		
		float q = (hsl.z < 0.5) ? (hsl.z * (1.0 + hsl.y)) : (hsl.z + hsl.y - hsl.z * hsl.y);
		float p = 2.0 * hsl.z - q;
		rgb.x = hue2channel(p, q, hsl.x + 1.0/3.0);
		rgb.y = hue2channel(p, q, hsl.x);
		rgb.z = hue2channel(p, q, hsl.x - 1.0/3.0);
	}
	
	return vec4(rgb.xyz,hsl.w);
}



bool isIntersecting(vec3 ray) {

    float aspect = iResolution.x/iResolution.y;

	float x = wrap((ray.x + aspect)/20.0,1.0);		
	float samplev = distance(vec2(0.0),texture(iChannel0,vec2(x)).xy) - 1.0;
	
	// trimming every once every two units
	// more like slicing :B
	// would have liked to have a smooth transition though...
	// ... but since it returns just a bool...
	// ... I'll probably try something else next time :] still learning
	
	float smoothTrim = smoothstep(0.0,1.0,mod(ray.z,2.0)/4.0);
	return smoothTrim > 0.2 && ray.y < sin(ray.x*PI)*cos(ray.z*PI)*samplev * 2.0 - 1.0;
	
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float aspect = iResolution.x/iResolution.y;

	// change coordinate system
	vec2 uv = fragCoord.xy / iResolution.xy * 2.0 - 1.0;
	uv.x *= aspect;
	
	//float time = iTime;
	
	float time = iTime*4.0;

	// to rotate the camera
	float angle = time/100.0*PI;
	
	// wavy movement
	float camY = cos(time/20.0 * PI)*3.0 + 4.5;
	// but still moving forward
	float camZ    = time/10.0;
	// we adapt the position of the screen
	// for a proper ray direction
	float screenY = camY-2.0;
	float screenZ = camZ+15.0;
	
	
	// our camera and the pixel it is looking at...
	vec3 camPos    = vec3(0.0,camY,camZ);
	vec3 pixelPos  = vec3(uv+vec2(0.0,screenY),screenZ);
	// ... gives us a direction
	vec3 direction = normalize(pixelPos-camPos);

	// rotate this direction 'cause it's cool
	// and I can show off my cool matrix
	mat3 Yrotation = mat3(
			-sin(angle),0.0,cos(angle),
		    0.0        ,1.0,0.0       ,
		    cos(angle) ,0.0,sin(angle)		
		);
	direction *= Yrotation;
	
	
	// starting point of the ray
	vec3 ray = pixelPos;
	float j = 0.0;
	/*
	for(int i = 0; i < MAX_ITERATION; i++) {
		if (!isIntersecting(ray)) {
			j++;
			ray += direction*DELTA;
		}

		if (int(j) != i) {
			break;	
		}
	}
	//*/
	
	/* doesn't work in chrome  26.0.1410.64 / Win7
	for(int i = 0; i < MAX_ITERATION; i++) {
		if (isIntersecting(ray)){
			break;
		}
		j++;
		ray += direction*DELTA;
	}
	//*/
	
	//* maybe without break then...
	for(int i = 0; i < MAX_ITERATION; i++) {
		if (!isIntersecting(ray)){
			j++;
			ray += direction*DELTA;
		}
	}
	//*/
	
	
	// gradient color
	float gradient = float(j)/float(MAX_ITERATION);	
	float hue = mix(START_HUE,END_HUE,gradient);	
	float sat = mix(START_SAT,END_SAT,gradient);
	
	vec4 baseColor = hslToRgb(vec4(hue,sat,0.5,1.0));	
	

	fragColor = baseColor;
	
	//texture overlay which fades in depth
	//vec4 texture = texture(iChannel1,ray.xz/10.0)*clamp((1.0-gradient*8.0),0.0,1.0) ;
	//fragColor = baseColor + mix(baseColor,texture,0.5);
	
	fragColor = 1.5 * baseColor;
	//*/

}