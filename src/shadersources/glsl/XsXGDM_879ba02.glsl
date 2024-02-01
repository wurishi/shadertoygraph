// by Nikos Papadopoulos, 4rknova / 2013
// WTFPL

#define BIAS  4.
#define LUMIN vec3(.2126, .7152, .0722)

void mainImage(out vec4 c, vec2 p)
{
	vec2 uv = p.xy / iResolution.xy;
	
	vec4 fg = texture(iChannel0, vec2(1) - uv);
	vec4 bg = texture(iChannel1, vec2(1) - uv);
	
	float sf = max(fg.r, fg.b);
	float k = clamp((fg.g - sf) * BIAS, 0., 1.);
	
	if (fg.g > sf) fg = vec4(dot(LUMIN, fg.xyz));
	
	c = mix(fg, bg, k);
}