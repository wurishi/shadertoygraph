void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec3 cam = vec3(.23352, .98722, 1.0+iTime*iTime*iTime*iTime*iTime*iTime/(10000.0));//(time*time)/10.0);
    vec2 size = iResolution.xy;

    vec2 p = vec2(2.5*fragCoord.x/(size.x*cam.z)-2.0+cam.x, 2.0*fragCoord.y/(size.y*cam.z)-1.0+cam.y);
	vec2 z = vec2(0.0, 0.0);
	int cnt = 0;
	for (int i = 0; i < 100; ++i){
		if (z.x*z.x + z.y*z.y <= 4.0) {
			z = vec2(z.x*z.x - z.y*z.y + p.x, z.r*z.y+z.y*z.r + p.y); cnt++;
		} else { break; }
}
        if(cnt==100) { fragColor = vec4(0.0, 0.0, 0.0, 1.0); } else { 
			float col = (mod(float(cnt)+iTime*9.0,10.0)/10.0);
			float col2 = (mod(float(cnt)+iTime*2.0,10.0)/10.0);
			fragColor = vec4((col2+col2)/2.0, (col+col2)/2.0, col+.2, 1.1);}
	}