
float ts = 0.0;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	
    vec3 cam = vec3(.23352, .98722, 1.0+iTime*iTime*iTime*iTime/(1000.0));//(time*time)/10.0);
	
	// sample and smooth out the lower frequencies
	float fft = (texture(iChannel0,vec2(.0, .0)).x);
	float fft2 = (texture(iChannel0,vec2(.025, .0)).x);
	float fft3 = (texture(iChannel0,vec2(.030, .0)).x);
	float th = fft*2.0 + fft2 + fft3;
	th = th / 4.0;
	
	// no hysterisis :(
	if(th > .65) ts = 1.0;
	vec2 p = vec2(2.5*fragCoord.x/(iResolution.x*cam.z*((sqrt(th))))-2.0+(cam.x),
				  2.0*fragCoord.y/(iResolution.y*cam.z*(sqrt(th)))-1.0+cam.y);
	vec2 z = vec2(0.0, 0.0);
	int cnt = 0;
	for (int i = 0; i < 100; ++i){
		if (z.x*z.x + z.y*z.y <= 4.0) {
			z = vec2(z.x*z.x - z.y*z.y + p.x, z.r*z.y+z.y*z.r + p.y); cnt++;
		} else { break; }
}
        if(cnt==100) { fragColor = vec4(0.0, 0.0, 0.0, 1.0); } else { 
			float col = (mod(float(cnt)+iTime*9.0+ts*10.0,30.0)/30.0);
			float col2 = (mod(float(float(cnt))+iTime+
							 ts*10.0,30.0)/30.0);
			fragColor = vec4((col2+col2)/2.0, (col+col2)/2.0, col+.2, 1.1);}
	}