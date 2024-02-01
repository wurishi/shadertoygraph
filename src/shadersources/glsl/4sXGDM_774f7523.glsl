const int iMax = 1024;     //adjust iterations

vec3 MBrot(vec2 c, vec2 z, vec2 uv) {
	float i = 0.0;
	for( int j=0; j<iMax; j++ )
	{
	    if( z.x*z.x + z.y*z.y > 2.0*2.0) 
			break;	
	
		z = vec2((z.x*z.x-z.y*z.y), (z.x*z.y+z.x*z.y))+c;
		i++;
	}
	if (i<1024.){
		return vec3 (i/1024.,i/512.,i/256.); 
	}
	else {
		return vec3(0.0,0.0,0.0);
	}
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = -1.0 + 2.0 * (fragCoord.xy / iResolution.xy);
    uv.x *= iResolution.x/iResolution.y;
       
	float ang = iTime*(-0.25);
	mat2 rotation = mat2(cos(ang), sin(ang),-sin(ang), cos(ang));
    //float f = (2.0/3.14)*asin(sin(2.0*3.14*iTime*0.05)); f*=abs(f*f*f); float zoom = f*1e3;
    float f = exp(sin(iTime*0.1-1.4))-1.0/exp(1.0); f*=f; float zoom = f*1e3; 	  
    uv/=zoom;
    uv*=rotation;
    uv.x-=1.2478;
    uv.y+=0.05225;
	vec2 c = vec2(uv.x, uv.y);
	vec2 z = vec2(0.0,0.0);
    
	vec3 col = MBrot(c, z, uv);
	
	fragColor = vec4(col,1.0);
}
