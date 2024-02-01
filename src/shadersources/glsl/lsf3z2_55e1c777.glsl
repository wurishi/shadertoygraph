#define M_PI 3.141592653589793
#define M_2PI 6.283185307179586

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = 2.0*(0.5 * iResolution.xy - fragCoord.xy) / iResolution.xx;
	float angle = atan(p.y, p.x);
	float turn = (angle + M_PI) / M_2PI;
	float radius = sqrt(p.x*p.x + p.y*p.y);

	float n = 9.0;
	float angle_offset = 5.1*sin(0.3*iTime);
	float k_amplitude = 0.9*cos(1.2*iTime);
	float radius2 = radius + pow(radius, 2.0)*k_amplitude*sin(n*angle + angle_offset);
	float width = 0.05;
	float k_t = -0.04;
	
	float n_inv = 1.0 / float(n);
	vec3 color;
	float modulus = mod(float(int((radius2 + k_t*iTime) / width)), 3.0);
	if(modulus < 1.0) {
		//color = vec3(0.5, 0.0, 0.8);
		color = vec3(0.0, 0.4, 0.3);
	} else if(modulus < 2.0) {
		color = vec3(0.9, 0.0, 0.1);
	} else {
		color = vec3(0.5, 0.3, 0.0);
	}
	color /= 0.2 + pow(radius, 2.0);
	
	fragColor = vec4(color, 1.0);
}