#define M_PI 3.1415926535897931

const float nyanStretch = .1;
const float nyanSpeed = 3.;
const vec2 nyanTexOffset = vec2(.25, .5);
float bailout = 2.;
const int maxiter = 50;
	
vec2 cplxmul(vec2 a, vec2 b) {
	return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

mat4 q4(vec4 q) {
	return mat4(
		q.w, q.x, q.y, q.z,
		-q.x, q.w, q.z, -q.y,
		-q.y, -q.z, q.w, q.x,
		-q.z, q.y, -q.x, q.w
		);
}

vec4 rotate4(vec4 src, vec4 lq, vec4 rq) {
	return (q4(lq) * q4(src) * q4(rq))[0];
}

vec4 samplef(vec2 p) {
	
	vec4 init = vec4(p, .5, .5);
	vec4 angle1 = texture(iChannel1, vec2(cos(.01 * iTime ), sin(.01 * iTime)));
	vec4 angle2 = texture(iChannel1, vec2(cos(.01 * iTime + .1), sin(.01 * iTime + .1)));
	init = rotate4(init, angle1, angle2);
	//rotate and translate, or translate and rotate
	vec2 c = init.xy;
	vec2 z = init.zw;
	
	float iter = 0.;
	for (int i = 0; i < maxiter; ++i) {
		z = cplxmul(z, z) + c;
		if (dot(z,z) > bailout*bailout) break;
		iter += 1.;
	}
	float fraciter = -(log2(log(bailout)) - log2(log(length(z))));
	
	iter = iter - (1. - fraciter);
	
	vec2 channelCoord = nyanTexOffset
		+ z * vec2(nyanStretch, -1.) 
		+ vec2(nyanSpeed, 1.) * vec2(iTime + sin(iTime), cos(iTime * 1.1));
	
	//mag up
	const float flickerMagn = 5.;
	channelCoord *= step(abs(cos(1./sin(.5*M_PI + 1.5 * iTime - .5))), .9) * (1. - 1. / flickerMagn) + 1. / flickerMagn;
	
	channelCoord = fract(channelCoord);	//nyan cat has no wrap texparam =(
	vec4 color = texture(iChannel0, channelCoord);
	
	//flicker
	color *= 2.;
	color -= 1.;
	color *= step(abs(cos(1./sin(.5*M_PI + iTime))), .9) * 2. - 1.;
	color += 1.;
	color /= 2.;
	
	return color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 aspectRatio = vec2(float(iResolution.x) / float(iResolution.y), 1.);
	vec2 uv =(2. * fragCoord.xy / iResolution.xy - vec2(1., 1.)) * aspectRatio;

	fragColor = samplef(uv);
	/*
	vec2 duv_dx = dFdx(uv);
	vec2 duv_dy = dFdy(uv);
	
	fragColor = .25 * (
		sample(uv)
		+ sample(uv + duv_dx * .5)
		+ sample(uv + duv_dy * .5)
		+ sample(uv + duv_dx * .5 + duv_dy * .5)
	);
	*/
}