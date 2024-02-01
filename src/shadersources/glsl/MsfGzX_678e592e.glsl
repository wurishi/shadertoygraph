void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float stepU = 1.0 / iResolution.x;
	float stepV = 1.0 / iResolution.y;
	
	float blurRatio = 8.0;
	stepU *= blurRatio;
	stepV *= blurRatio;
	
	//vec4 britneyColor = 
	//	texture(iChannel0, fragCoord.xy / iResolution.xy);
	
	// http://www.gamedev.net/topic/507209-pixel-shader-gaussian-blur/
	mat3 gaussianCoef = mat3(
		1.0,	2.0,	1.0,
		2.0,	4.0,	2.0,
		1.0,	2.0,	1.0);

	vec4 result = vec4(0.0);
	for(int i=0;i<3;i++) 
	{
		for(int j=0;j<3;j++) 
		{
			vec2 texCoord = fragCoord.xy / iResolution.xy
				+ vec2( float(i-1)*stepU, float(j-1)*stepV )
				;
			result += 
				gaussianCoef[i][j] * texture(iChannel0,texCoord);
		}

	}
	
	fragColor = result/16.0;
	//fragColor = vec4(1.0, 0.0, 0.0, 1.0);
}