#define pi 3.141592653589793238462643383279
#define pi_inv 0.318309886183790671537767526745

vec2 complex_mul(vec2 factorA, vec2 factorB){
  return vec2( factorA.x*factorB.x - factorA.y*factorB.y, factorA.x*factorB.y + factorA.y*factorB.x);
}

vec2 complex_div(vec2 numerator, vec2 denominator){
   return vec2( numerator.x*denominator.x + numerator.y*denominator.y,
                numerator.y*denominator.x - numerator.x*denominator.y)/
          vec2(denominator.x*denominator.x + denominator.y*denominator.y);
}

vec2 wrap_flip(vec2 uv){
	return vec2(1.)-abs(fract(uv*.5)*2.-1.);
}
 
float border(vec2 domain, float thickness){
   vec2 uv = fract(domain-vec2(0.5));
   uv = min(uv,1.-uv)*2.;
   return clamp(max(uv.x,uv.y)-1.+thickness,0.,1.)/(thickness);
}

float circle(vec2 uv, vec2 aspect, float scale){
	return clamp( 1. - length((uv-0.5)*aspect*scale), 0., 1.);
}

float sigmoid(float x) {
	return 2./(1. + exp2(-x)) - 1.;
}

float smoothcircle(vec2 uv, vec2 center, vec2 aspect, float radius, float sharpness){
	return 0.5 - sigmoid( ( length( (uv - center) * aspect) - radius) * sharpness) * 0.5;
}

float lum(vec3 color){
	return dot(vec3(0.30, 0.59, 0.11), color);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// domain map
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	// aspect-ratio correction
	vec2 aspect = vec2(1.,iResolution.y/iResolution.x);
	vec2 uv_correct = 0.5 + (uv -0.5)/ aspect.yx;
	vec2 mouse_correct = 0.5 + ( iMouse.xy / iResolution.xy - 0.5) / aspect.yx;
	
	vec2 pos1 = vec2(0.5);//mouse_correct;
	
	float angle = atan(uv_correct.y - pos1.y, uv_correct.x - pos1.x);
	float phaseshift = -iTime*0.1;
	vec2 spectrum_uv = fract(vec2( -angle * pi_inv*0.5 + phaseshift, 0.25));
	
	float spectrum = lum(texture(iChannel0, spectrum_uv).rgb);
	
	float d = 0.1 + spectrum*0.3;
	float sharpness = 300.;
	float circle = smoothcircle(uv_correct, pos1, vec2(1), d, sharpness);
	float circle_outline = circle*(1.-circle)*4.;
		
	float grid = border((uv_correct - 0.5)*16., 0.1);

	fragColor = vec4(uv,0.,1.0);

	fragColor = mix(fragColor, vec4(1), grid);
	fragColor = mix(fragColor, vec4(0), circle*0.5);
	fragColor = mix(fragColor, vec4(1), circle_outline);
}