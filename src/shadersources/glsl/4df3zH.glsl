#define pi 3.141592653589793238462643383279

float atan2(float y, float x){
	if(x>0.) return atan(y/x);
	if(y>=0. && x<0.) return atan(y/x) + pi; 
	if(y<0. && x<0.) return atan(y/x) - pi; 
	if(y>0. && x==0.) return pi/2.;
	if(y<0. && x==0.) return -pi/2.;
	if(y==0. && x==0.) return pi/2.; // undefined usually
	return pi/2.;
}

vec2 uv_polar(vec2 uv, vec2 center){
	vec2 c = uv - center;
	float rad = length(c);
	float ang = atan2(c.x,c.y);
	return vec2(ang, rad);
}

vec2 uv_lens_half_sphere(vec2 uv, vec2 position, float radius, float refractivity){
	vec2 polar = uv_polar(uv, position);
	float cone = clamp(1.-polar.y/radius, 0., 1.);
	float halfsphere = sqrt(1.-pow(cone-1.,2.));
	float w = atan2(1.-cone, halfsphere);
	float refrac_w = w-asin(sin(w)/refractivity);
	float refrac_d = 1.-cone - sin(refrac_w)*halfsphere/cos(refrac_w);
	vec2 refrac_uv = position + vec2(sin(polar.x),cos(polar.x))*refrac_d*radius;
	return mix(uv, refrac_uv, float(length(uv-position)<radius));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// domain map
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	// aspect-ratio correction
	vec2 aspect = vec2(1.,iResolution.y/iResolution.x);
	vec2 uv_correct = 0.5 + (uv -0.5)* aspect;
	vec2 mouse_correct = 0.5 + ( iMouse.xy / iResolution.xy - 0.5) * aspect;

	vec2 pos = vec2(0.5);
//	pos = mouse_correct;
	
	vec2 uv_lens_distorted = uv_lens_half_sphere(uv_correct, pos, 0.166, 1.575);
	
	uv_lens_distorted = 0.5 + (uv_lens_distorted - 0.5) / aspect;
	
	fragColor = texture(iChannel0, uv_lens_distorted);

}