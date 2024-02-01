const float Soft = 0.001;
const float Threshold = 0.3;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float f = Soft/2.0;
	float a = Threshold - f;
	float b = Threshold + f;
	
	vec4 tx = texture(iChannel0, fragCoord.xy/iResolution.xy);
	float l = (tx.x + tx.y + tx.z) / 3.0;
	
	float v = smoothstep(a, b, l);
	
	fragColor= vec4(v);

}