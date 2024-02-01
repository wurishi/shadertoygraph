/* Use a mapping from 2D to 1D to draw a hilbert curve using a shader.
Wikipedia gives an algorithm, which I adapted to GLSL ES 2.0.

To do:

x- draw a black line along the curve. I can't get the path
to be legible otherwise.
- shade "outside" a little differently from "inside"?
There is no real inside, so we'd have to "cheat" to define one.
We could say "starboard" vs. "port" as we're facing increasing d.
This is partly working, but comes out flipped 50% of the time.
- to do: do something with mouse position ... e.g. highlight the H curve
   for some distance on either side of the mouse?
- could make this a raymarched heightfield, where the curve
  is a long mountain ridge; and in between is "water";
  and make jagged, colored etc. like IQ's mountains.
  View from side/above, and rotate the Hilbert range.
- a use for d: have fbm particles flowing along the curve,
  parameterized by d (plus time).
  */


const float maxLevels = 7.0;


// rand()/noise()/fbm() copied from Fire by @301z (https://www.shadertoy.com/view/Xsl3zN)

float rand(vec2 n) { 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 n) {
	const vec2 d = vec2(0.0, 1.0);
	vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
	return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

float fbm(vec2 n) {
	float total = 0.0, amplitude = 1.0;
	for (int i = 0; i < 7; i++) {
		total += noise(n) * amplitude;
		n += n;
		amplitude *= 0.5;
	}
	return total;
}

// #define lenq (dot(q, q)) // experiment for performance
#define lenq (length(q))

// What is the minimum distance of point q from
// a line segment from the origin to dir?
// Return negative values for points on the "left" (relative
// to direction of dir).
float distFrom1(vec2 q, vec2 dir) {
	// At least one of dir.x and dir.y will always be zero.
	if (dir.x == 0.0) {
		if (dir.y == 0.0) { // dir is zero
			return lenq;
		} else { // dir is vertical
			if (sign(q.y) == sign(dir.y))
				return q.x * dir.y; // use dir.y to flip sign of q.x
			else
				return lenq;
		}
	} else { // dir is horizontal
		if (sign(q.x) == sign(dir.x))
			return q.y * dir.x; // use dir.x to flip sign of q.y
		else
			return lenq;	
	}
}

// What is the minimum distance of point q from
// a pair of line segments that go from the origin to
// predir and postdir respectively?
// Return negative values for points on the "left" (relative
// to direction of postdir).
float distFrom(vec2 q, vec2 predir, vec2 postdir) {
	// q is the vector from (s,s) to p.
	q *= 2.0;

#ifdef OLD		

	// q is vector from (s,s) to p. Is q closer to predir or to postdir?
	vec2 qpre = q - predir;
	vec2 qpost = q - postdir;

	vec2 relevantDir;
	if (dot(qpre, qpre) > dot(qpost, qpost)) {
		relevantDir = postdir;
	} else {
		relevantDir = -predir;
	}
	return -q.y * relevantDir.x + q.x * relevantDir.y;
#else
	float c1 =  distFrom1(q, predir);
	float c2 = -distFrom1(q, postdir);
	
	return (abs(c1) > abs(c2)) ? c2 : c1;
#endif // OLD
}

// Given point p in square (0,0) to (n,n), return distance d along (an approxmation of)
// a Hilbert curve.  d varies from 0 to n^2-1. 
// n in effect is the "resolution" of the approximation, i.e. n = 2^i, for the
// i'th approximation of the Hilbert curve.
// Also returns c, which indicates lateral distance *from* the center line of the curve.
// When p is to "starboard" of the curve, relative to the direction of increasing d
// at that point, c > 0. To port is c < 0. (Actually the sign of c is not quite working ATM.)
// In all cases abs(c) <= 1.
// In the limit (i -> infinity), all points are on the Hilbert curve (c = 0),
// but at the i'th approximation, most are not.
int hilbert(int n, vec2 p, out float c) {
	int d=0;
	// Direction of tails coming before/after the "staple" shape in a sub-square.
	vec2 predir, postdir;
	predir = postdir = vec2(0.0, 0.0);
	bool rx, ry; // quadrant that x,y falls in.
	c = 0.0; // initialize

	// Iterate (i-1) times, where n = 2^i.
	// We want     for (s=n/2; s>0; s/=2) {
	// but GLSL ES 2.0 doesn't support general loops...
	float s = float(n) * 0.5; // s could be an int.
	// We don't expect n > 2**14.
	// On each iteration, translate and rotate p to the proper quadrant.
	// s is half the size of the square under consideration, which halves each time.
	for (int i=0; i < 14; i++) {
		// Determine which quadrant p is in.
		rx = (p.x > s);
		ry = (p.y > s);
		// Lengthen d according to the number of quadrants before rx,ry.
		d += int(s * s) * (rx ? (3 - int(ry)) : int(ry));

		// terminate loop
		if (s < 0.75) { // s should be 0.5, but allow for rounding error
			c = distFrom(p - s, predir, postdir);
			return d; 
		}
			
		// calculate pre/postdir. The first pre and last post are unmodified.
		if (rx || ry)
			// was: predir = rx ? (ry ? vec2(-1.0, 0.0) : vec2(0.0, -1.0)) : vec2(1.0, 0.0);??
			predir = rx ? (ry ? vec2(-1.0, 0.0) : vec2(0.0, 1.0)) : vec2(0.0, -1.0);
		if (!rx || ry)
			// was: postdir = rx ? vec2(0.0, -1.0) : (ry ? vec2(1.0, 0.0) : vec2(0.0, 1.0));
			postdir = rx ? vec2(0.0, -1.0) : (ry ? vec2(1.0, 0.0) : vec2(0.0, 1.0));

		// Transform x,y to lower left quadrant.
		if (rx) p.x -= s;
		if (ry) {
			p.y -= s;
		} else { // if (!ry)
			// Rotate/flip if needed.
			if (rx) {
				// was: p = vec2(s - 1.0) - p;
				p = vec2(s) - p; // flip
				predir = -predir;
				postdir = -postdir;
			}
	
			p.xy = p.yx; //Swap x and y
			predir.xy = predir.yx;
			postdir.xy = postdir.yx;
		}
		s *= 0.5;
	}
	return d;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	/* to do: make n the biggest power of 2 <= minimum of iResolution x and y */
	float minRes = min(iResolution.x, iResolution.y);
	vec2 offset = (iResolution.xy - vec2(minRes)) * 0.5;
	// vec3 bgcolor = bg();
	if (fragCoord.x < offset.x ||
		fragCoord.x > offset.x + minRes ||
		fragCoord.y < offset.y ||
		fragCoord.y > offset.y + minRes) {
		// Outside the box? Do a sunbursty thing.
		vec2 p = fragCoord.xy - (iResolution.xy * 0.5);
		float a = atan(p.y, p.x);
		float a1 = a + iTime * 0.5;
		float a2 = a1 - iTime;
		vec3 col = vec3(sin(a1 * 11.0) * 0.25 + 0.65, sin(a1 * 11.0) * 0.25 + 0.95,
						sin(a2 * 17.0) * 0.25 + 0.95);
		float intensity = sin(a2 * 7.0) * 0.25 + 0.75;
		fragColor = vec4(col * 0.2 * intensity + 0.4, 1.0);
		return;
	}
	
	int n = int(pow(2.0, floor(mod(iTime * 0.5, maxLevels)) + 1.0));
	vec2 p = vec2((fragCoord.xy - offset) * float(n) / minRes);
	float c;
	float d = float(hilbert(n, p, c));
	//  d /= float(n*n)? // scale to 1
	float inten = mod(iTime * 10.0 + d, 10.0) > 7.0 ? 0.5 : 1.0;
	// TODO: make color vary faster, but have longer period...
	// maybe r,g, and b will each be sine waves with different periods.
	// d += iTime * 100.0; // optional...
	/* nice color:
	vec3 periods = vec3(0.07, 0.09, 0.11) * 0.05; //  / iTime
	vec3 color = vec3(sin(d * periods.r), sin(d * periods.g),
		sin(d * periods.b)) * 0.4 * inten + 0.5;
	fragColor = vec4(color, 1.0);
	*/
	/*
	fragColor = vec4(mod(d / float(n*n), 1.0));
	*/

	c = min(1.0, abs(c));
	vec2 ph = vec2(d / float(n*n), c);
    float q = fbm(ph - iTime * 0.1);
	float r = fbm(ph + q + iTime * 0.7 - ph.x - ph.y);

#ifdef LEFTRIGHT
	if (c > 0.0) c = 1.0 - c;
	// else c = (1.0 + c) * (1.0 + c);
	else c = (1.0 + c) * mod(c, 0.01) * 100.0;
#else
	//c = abs(c);
	c = pow(1.0 - min(abs(c), 1.0), 2.0);
#endif //LEFTRIGHT
	
	vec3 col = vec3(0.7, 0.7, 1.0) * 1.3;
	// mix(bg, col, c)
	fragColor = vec4(col * (c + r), 1.0);
}
