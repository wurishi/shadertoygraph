void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 p = 2.0 * uv - 1.0;
	p.x *= iResolution.x/iResolution.y;
	
	vec3 final = vec3(0.0);
	vec3 white = vec3(1.0);
	float radius = 0.6;
	
	float area = 1.0-floor(clamp(length(p*1.4),0.0,1.0));
	float areaOuter = 1.0-floor(clamp(length(p*1.3),0.0,1.0));
	
	float teeth = sin(-4.7+p.x*30.0);
	if(teeth > 0.5)
		final = white;
	//final = white * clamp(sin(p.x*30.0)*1000.0,0.0,1.0);
	
	if(p.y < 0.0 && p.y > -.05)
		final = white;
	if(p.y > 0.0)
		final = vec3(0.0);
	final *= area;
	final += areaOuter - area;
	
	vec2 b;
	
	//nose
	b = p + vec2(0.0,-0.15);
	if(length(b)<0.1)
		final += white;
	
//eyes
	float cp1 = 0.2+sin(iTime*4.0)*0.01;
	b = p + vec2(-0.26,-0.36);
	if(length(b)<cp1)
		final += white;
	
	float cp2 = 0.2+sin(iTime*6.0)*0.02;
	b = p + vec2(0.26,-0.36);
	if(length(b)<cp2)
		final += white;
	
	//ears
	float wobble = 0.3+sin(iTime*5.0)*0.01;
	
	b = p + vec2(-0.46,-0.56);
	if(length(b)<wobble)
		final += white * (1.0 - areaOuter);
	
	b = p + vec2(0.46,-0.56);
	if(length(b)<wobble)
		final += white * (1.0 - areaOuter);
	
	
	final = white - final;
	fragColor = vec4(final,1.0);
}