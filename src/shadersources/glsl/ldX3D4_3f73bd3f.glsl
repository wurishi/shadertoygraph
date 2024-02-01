const int kPostarizationPower = 64; //input (1~256)


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 col = texture( iChannel0, fragCoord.xy / iResolution.xy );
	
	float div = 256.0/float( kPostarizationPower );
	
	fragColor = floor( col * div ) / div;
}