// It is necessary to add the Overtone vars.
uniform float iOvertoneVolume;

#define _numberOfWaves 4

void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{
    vec2 uv  = 2.0*(fragCoord.xy/iResolution.xy) - 1.0;
    uv.y = 0.25 - uv.y;
	
	float spec_y = 0.25;// + 500.0*iOvertoneVolume;
    float col = 0.0;
    
	//int _numberOfWaves = 2;
	
	uv.y += sin(iTime * 10.0 + uv.x *3.)*spec_y;
    col += abs(0.066/uv.y) * spec_y;
	
	//float h = (uv.y-0.01)/(0.4-0.3);
	float h = (uv.y - .1)/(0.4-0.3);
	vec3 bg = vec3(0.0,51.0/255.0,102.0/255.0);
	
	h 	= floor( h*5.0 );
	
	//int t = 0;
	//for(int t = 0; t < _numberOfWaves; t++)
	bg 	= mix( bg, vec3(1. - col ,col/2.,col), 		1. - abs(h-1.));
	bg 	= mix( bg, vec3(1. - col ,col/2.,col), 		1. - abs(h-2.));
	bg  = mix( bg, vec3(col,col/7.,col/3.),   		1. - abs(h-3.));
	bg  = mix( bg, vec3(col/3.,1. - col,col/7.),    1. - abs(h-4.));
	
	fragColor = vec4(bg,1.0);
	
    
	//uv2   	= uv;
	//uv2.y 	=  0.015 + uv2.y;
	//uv2 	= mix( uv, uv2, 1.0 - smoothstep( 0.0, 0.1, 1. ));
	
	
	
	//fragColor = vec4(1. - col,col/2.,col,1.0);
}