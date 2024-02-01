const float PI = 3.14;
const float stripes = 10.0;
const float waves = 10.0;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.x *= iResolution.x/iResolution.y;
	
	vec2 light_pos = uv - 0.5 + vec2(sin(iTime), cos(iTime*0.3)) * 0.5;
	
	//generate some waves	
	float wobble = 0.5 + 0.5 * sin(uv.y * stripes * PI * 2.0 + cos(uv.x * PI * 2.0 * waves));

	float diffuse = 1.0 - length(light_pos);

	//modulate by the diffuse term
	wobble += diffuse;
	
	//sharpen the transitions	
	wobble = smoothstep(0.6, 0.7, wobble);
	
	fragColor = vec4(wobble);	
}