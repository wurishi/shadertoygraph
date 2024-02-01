const float pi = 3.14159;
const float rep = pi*0.25;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord.xy / iResolution.xy;
	vec2 mouse = iMouse.xy / iResolution.xy;

	p -= 0.5;
    float a = atan(p.y, p.x) + pi;;
    float r = length(p);
	a = mod(a, rep);
	a = abs(a - rep*0.5);
	p = vec2(r * cos(a), r*sin(a));
	p.y += 0.5;
	
	fragColor = texture(iChannel0, p);
}