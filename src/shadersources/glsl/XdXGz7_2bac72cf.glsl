void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy - (iResolution.xy/2.0)) / iResolution.xy;
	
	float dist = sqrt(uv.x*uv.x+uv.y*uv.y);
	
	float distr = ((sin(iTime)+1.0)-dist) * sin(atan(uv.x, uv.y)*7.0+iTime*4.01+sin(dist*(cos(iTime*0.3)+0.25)*40.0));
	float distg = ((sin(iTime*0.9)+1.0)-dist) * sin(atan(uv.x, uv.y)*8.0+iTime*3.41+sin(dist*(cos(iTime*0.25)+0.25)*40.0));
	float distb = ((sin(iTime*1.15)+1.0)-dist) * sin(atan(uv.x, uv.y)*9.0+iTime*4.36+sin(dist*(cos(iTime*0.33)+0.25)*40.0));
	
	fragColor = vec4(distr+distg-distb, distg+distb-distr, distb+distr-distg, 1.0);
}