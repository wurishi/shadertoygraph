#define C(a) clamp(a*w/s, 0., 1.)
float S(vec2 p, vec2 a, vec2 b)
{
	b -= a; p -= a;
	b *= clamp(dot(p,b) / dot(b,b), 0., 1.);
	return length(p-b);
}
#define L(a) vec2(x+a-.5, fract(sin(x+a)*1e4)*.25*s+(x+a)*.5)
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float s = 20., w = iResolution.x, t = iTime;
	
	vec2 p = (fragCoord.xy / w)*s + vec2(t-s*.25,t*.5);
	
	float x = floor(p.x);
	
	float d = min(S(p, L(0.), L(1.)), S(p, L(1.), L(2.)))-.2;

	p = abs(fract(p)-.5)-.01;
	
	fragColor.rgb = mix(vec3(.1,.9,.1) * C(max(abs(d)-.05, 0.0)), vec3((1.-C(min(p.x, p.y)))*.2+.2), C(d));
}