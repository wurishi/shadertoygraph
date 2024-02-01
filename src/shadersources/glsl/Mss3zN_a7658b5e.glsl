//cheap bokeh effect
//by MrOMGWTF

float stepsize = 0.0;

vec2 stepdir(int n)
{
	if(n == 0) return vec2(0.0, stepsize);
	if(n == 1) return vec2(0.0, -stepsize);
	if(n == 2) return vec2(stepsize, 0.0);
	if(n == 3) return vec2(-stepsize, 0.0);	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	stepsize = abs(sin(iTime * 0.67)) * (1.0 / 160.0);
	vec2 uv = fragCoord.xy / iResolution.xy;

	vec4 color = texture(iChannel0, uv);
	
	vec4 n1, n2, n3, n4, n5, n6, n7, n8;
	n1 = texture(iChannel0, uv + stepdir(0));
	n2 = texture(iChannel0, uv + stepdir(1));
	n3 = texture(iChannel0, uv + stepdir(2));
	n4 = texture(iChannel0, uv + stepdir(3));
	
	n5 = texture(iChannel0, uv + stepdir(0) * 2.0);
	n6 = texture(iChannel0, uv + stepdir(1) * 2.0);
	n7 = texture(iChannel0, uv + stepdir(2) * 2.0);
	n8 = texture(iChannel0, uv + stepdir(3) * 2.0);
	
		
	color = max(max(max(n1, n2), max(n3, n4)), max(max(n5, n6), max(n7, n8)));
	
	fragColor = color;
}