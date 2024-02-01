vec2 complex_mul(vec2 factorA, vec2 factorB){
   return vec2( factorA.x*factorB.x - factorA.y*factorB.y, factorA.x*factorB.y + factorA.y*factorB.x);
}

vec2 torus_mirror(vec2 uv){
	return vec2(1.)-abs(fract(uv*.5)*2.-1.);
}

float circle(vec2 uv, float scale){
	return clamp( 1. - length((uv-0.5)*scale), 0., 1.);
}

float sigmoid(float x) {
	return 2./(1. + exp2(-x)) - 1.;
}

float smoothcircle(vec2 uv, float radius, float sharpness){
	return 0.5 - sigmoid( ( length( (uv - 0.5)) - radius) * sharpness) * 0.5;
}

float border(vec2 domain, float thickness){
   vec2 uv = fract(domain-vec2(0.5));
   uv = min(uv,1.-uv)*2.;
   return clamp(max(uv.x,uv.y)-1.+thickness,0.,1.)/(thickness);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 aspect = vec2(1.,iResolution.y/iResolution.x);
	vec2 uv = 0.5 + (fragCoord.xy * vec2(1./iResolution.x,1./iResolution.y) - 0.5)*aspect;
	vec2 mouse = iMouse.xy / iResolution.xy;
	float mouseW = atan((mouse.y - 0.5)*aspect.y, (mouse.x - 0.5)*aspect.x);
	vec2 mousePolar = vec2(sin(mouseW), cos(mouseW));
	vec2 offset = (mouse - 0.5)*4.;
	offset =  - complex_mul(offset, mousePolar) + iTime*0.05;
	vec2 uv_distorted = uv;

	// original loop that caused problems with different GPUs
	/*
	for (float i = 0.; i < 4.; i++){
		float filter = smoothcircle(uv_distorted, 0.12, 24.);
		uv_distorted = torus_mirror(0.5 + complex_mul(((uv_distorted - 0.5)*mix(2., 16., filter)), mousePolar) + offset);
	}
	*/
	
	//manually unrolled loop
	float _filter;
	_filter = smoothcircle(uv_distorted, 0.12, 24.);
	uv_distorted = torus_mirror(0.5 + complex_mul(((uv_distorted - 0.5)*mix(2., 16., _filter)), mousePolar) + offset);
	_filter = smoothcircle(uv_distorted, 0.12, 24.);
	uv_distorted = torus_mirror(0.5 + complex_mul(((uv_distorted - 0.5)*mix(2., 16., _filter)), mousePolar) + offset);
	_filter = smoothcircle(uv_distorted, 0.12, 24.);
	uv_distorted = torus_mirror(0.5 + complex_mul(((uv_distorted - 0.5)*mix(2., 16., _filter)), mousePolar) + offset);
	_filter = smoothcircle(uv_distorted, 0.12, 24.);
	uv_distorted = torus_mirror(0.5 + complex_mul(((uv_distorted - 0.5)*mix(2., 16., _filter)), mousePolar) + offset);

	
	fragColor = vec4(circle(uv_distorted, 1.4));

	//fragColor.zw = vec2(0);
	//fragColor.xy = uv_distorted; // domain map

}