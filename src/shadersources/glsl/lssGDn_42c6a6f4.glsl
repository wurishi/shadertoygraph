// by nikos papadopoulos, 4rknova / 2013
// WTFPL

// Notes
// p: Screen coordinates in [-a,a]x[-1,1] space (aspect corrected).
// t: The texture uv coordinates.
//	  u: The angle between the positive x axis and p.
//	  v: The inverse distance of p from the axis origin.
// s: Scrolling offset to create the illusion of movement.
// z: Texture uv scale factor.
// m: Brightness scale factor.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2  p = (2. * fragCoord.xy / iResolution.xy - 1.)
		    * vec2(iResolution.x / iResolution.y,1.);
	vec2  t = vec2(atan(p.x, p.y) / 3.1416, 1. / length(p));
	vec2  s = iTime * vec2(.1, 1);
	vec2  z = vec2(3, 1);
	float m = t.y + .5;

	fragColor = vec4(texture(iChannel0, t * z + s).xyz / m, 1);
}