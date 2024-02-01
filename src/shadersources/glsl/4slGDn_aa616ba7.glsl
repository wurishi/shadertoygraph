// by Nikos Papadopoulos, 4rknova / 2013
// WTFPL

#define F vec3(.2126, .7152, .0722)

void mainImage(out vec4 c, vec2 p)
{
	c = vec4(vec3(dot(texture(iChannel0, p.xy / iResolution.xy).xyz,F)), 1);
}