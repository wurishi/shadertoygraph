// Copyright (c) 2012-2013 Andrew Baldwin (baldand)
// License = Attribution-NonCommercial-ShareAlike (http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US)
// "Riley"
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 c = .025*fragCoord.xy;
	float t = iTime;
	float n = (1.+c.y)*7.;
	float m = mod(n+.5*c.x+.5*(.5+.4*sin((t+c.y)*6.283))*sin((c.x+t)*6.283),1.);
	float e = smoothstep(.75,.5,m)*smoothstep(.25,.5,m);
	fragColor = vec4(vec3(e),1.0);
}