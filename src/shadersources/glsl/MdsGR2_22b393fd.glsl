#define M_PI 3.141592653589793
#define M_2PI 6.283185307179586

bool bit(float quantity, float quantity_n, float quantity_kt) {
	float quantity_t = quantity + quantity_kt*iTime;
	return mod(quantity_t*quantity_n, 2.0) < 1.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = 2.0*(0.5 * iResolution.xy - fragCoord.xy) / iResolution.xx;
	float angle = atan(p.y, p.x);
	float turn = (angle + M_PI) / M_2PI;
	float radius = sqrt(p.x*p.x + p.y*p.y);
	
	float radius_offset = 0.7;
	float radius_power = 11.0;
	
	bool turn_bit = bit(turn, 20.0, -0.1);
	bool turn2_bit = bit(turn, 20.0, 0.1);
	bool radius_bit = bit(pow(radius + radius_offset, radius_power), 18.0, -0.6);
		
	float c;
	if((turn_bit == turn2_bit) == radius_bit) {
		c = 1.0;
	} else {
		c = 0.0;
	}
	
	fragColor = vec4(c, c, c, 1.0);
}