//http://web.engr.oregonstate.edu/~zhange/images/tenflddesn.pdf
//and maybe some other sources

//pick one of these:
//#define ADVECT_VECTOR
#define ADVECT_TENSOR

//pick one of these:
#define INTEGRATE_EULER
//#define INTEGRATE_RK4

#define MAX_ITERATIONS	100

const vec3 greyscale = vec3(.3, .6, .1);
const float dt = .1;

vec2 calcGradient(vec2 p) {
	vec2 dxy = vec2(1.) / iResolution.xy;
	vec2 dx = vec2(dxy.x, 0.);
	vec2 dy = vec2(0., dxy.y);
	//3x3 greyscale intensity window
	float i00 = dot(texture(iChannel0, p - dxy).rgb, greyscale);
	float i10 = dot(texture(iChannel0, p - dy).rgb, greyscale);
	float i20 = dot(texture(iChannel0, p - dy + dx).rgb, greyscale);
	float i01 = dot(texture(iChannel0, p - dx).rgb, greyscale);
	float i11 = dot(texture(iChannel0, p).rgb, greyscale);
	float i21 = dot(texture(iChannel0, p + dx).rgb, greyscale);
	float i02 = dot(texture(iChannel0, p - dx + dy).rgb, greyscale);
	float i12 = dot(texture(iChannel0, p + dy).rgb, greyscale);
	float i22 = dot(texture(iChannel0, p + dxy).rgb, greyscale);
	//Scharr filter
	vec2 g;
	g.x = 3. * i02 + 10. * i12 + 3. * i22
			 - 3. * i00 - 10. * i10 - 3. * i20;
	g.y = 3. * i20 + 10. * i21 + 3. * i22
			 - 3. * i00 - 10. * i01 - 3. * i02;
	
	g.y = -g.y;
	return g;
}

//http://www.math.harvard.edu/archive/21b_fall_04/exhibits/2dmatrices/index.html
vec2 eigen(mat2 structure, out vec2 eig1) {
	float tr = structure[0].x + structure[1].y;
	float det = structure[0].x * structure[1].y - structure[0].y * structure[1].x;
	float gap = sqrt(tr * tr - 4. * det);
	vec2 lambda = .5 * vec2(tr + gap, tr - gap);
	if (structure[0].y == 0. && structure[1].x == 0.) {
		eig1 = vec2(1., 0.);
	} else if (structure[0].y == 0.) {
		eig1 = vec2(structure[1].x, lambda.x - structure[0].x);
	} else {
		eig1 = vec2(lambda.x - structure[1].y, structure[0].y);
	}
	return lambda;
}

vec2 calcMovement(vec2 np, vec2 lastdp) {
#ifdef ADVECT_VECTOR
	// Gradient-based <=> Vector Induced Edge Field
	vec2 grad = calcGradient(np);
	grad = vec2(-grad.x, -grad.y);
	vec2 dp = grad;
#endif

#ifdef ADVECT_TENSOR
	// Structure Matrix <=> Tensor Induced Edge Field
	//http://en.wikipedia.org/wiki/Structure_tensor
	vec2 f = calcGradient(np);
	mat2 structure = mat2(f.x * f.x, f.x * f.y, f.x * f.y, f.y * f.y);
	vec2 eig1;
	vec2 lambda = eigen(structure, eig1);
	vec2 dp = eig1;
#endif
	
	//dp = normalize(dp);
	if (dot(dp, lastdp) < 1.) dp = -dp;
	return dp;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 dxy = vec2(1.) / iResolution.xy;
	vec2 p = fragCoord.xy / iResolution.xy;
	//color at point
	vec3 pointColor = texture(iChannel0, p).rgb;
	//backward trace
	vec3 resultColor = pointColor;
	vec3 lastPointColor = pointColor;
	//float avgWeight = 1.;
	vec2 np = p;
	vec2 lastdp = vec2(0.);
	float colorInfluence = 0.;
	for (int i = 0; i < MAX_ITERATIONS; ++i) {
		if (mod(floor(np * iResolution.xy), 4.) == vec2(0.)) {
			colorInfluence = 1.;
		}
		
#ifdef INTEGRATE_EULER
		vec2 dp = calcMovement(np, lastdp);
		np += dt * dp * dxy;
#endif
		
#ifdef INTEGRATE_RK4
		vec2 dp1 = calcMovement(np, lastdp);
		vec2 dp2 = calcMovement(np + .5 * dt * dp1, lastdp);
		vec2 dp3 = calcMovement(np + .5 * dt * dp2, lastdp);
		vec2 dp4 = calcMovement(np + dt * dp3, lastdp);
		vec2 dp = (dp1 + 2. * dp2 + 2. * dp3 + dp4) * (1. / 6.);
		np += dt * dp * dxy;
#endif
		
		lastdp = dp;
		
		//resultColor += texture(iChannel0, np).rgb;
		//avgWeight += 1.;
	}
	//resultColor /= avgWeight;

	//last color
	resultColor = texture(iChannel0, np).rgb;
	
	resultColor *= colorInfluence;
	
	//cell shade while we're here?
	
	/* color by distance travelled? * /
	vec2 delta = np - p;
	float l = dot(delta,delta);
	resultColor.r = 1. / (1. + 1000000. * l);
	resultColor.gb = vec2(0.);
	/**/
	
	vec2 delta = (np - p) * iResolution.xy;
	float deltaLenSq = dot(delta, delta);
	if (deltaLenSq < 2.) {
		fragColor = vec4(0.);
	} else {
		fragColor = vec4(resultColor, 1.);
	}
}