


// It is necessary to add the Overtone vars.
uniform float iOvertoneVolume;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{
  
	
	// GET THE CENTER !!
	vec2 uv = (fragCoord.xy / iResolution.xy);
 
	uv.x = uv.x + 0.5*sin(0.5*iTime);
    uv.y = uv.y + 0.05*cos(0.5*iTime);
  
	vec4 c1 = texture(iChannel1,uv);
  	vec4 c2 = texture(iChannel2,uv);
  	vec4 c = mix(c1,c2,1.0-c1.w);
  
	fragColor = c;
	
	
	
	
	 /*
		// GET THE CENTER !!
	vec2 uv = (fragCoord.xy / iResolution.xy);
  
	// FIND THE CENTER AND USE DISTANCE FROM CENTER TO VARY THE GREEN COMPONENT !!
  	vec2 uv2 = uv - 0.5;
 	float r = sqrt(uv2.x*uv2.x + uv2.y*uv2.y);
  	
	
	// BOTH ARE SAME !!
	fragColor = vec4(uv.y, 2.0*iTime*(1.-r),0.5*sin(3.0*iTime)+0.5,1.0);
	//fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
   */
}