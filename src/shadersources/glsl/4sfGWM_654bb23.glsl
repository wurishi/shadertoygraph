
vec2 cs(float t) {
	return vec2((pow(1.0+sin(t*3.11), 1.3)-.5) * (0.2 + 0.2*cos(t*2.31)), 
	(pow(1.0+sin(t*4.0), 1.5)-.5) * (0.2 + 0.2*sin(t*1.4)));
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 uv2 = fragCoord.xy / iResolution.x;
	vec2 texc = fragCoord.xy / iResolution.y;
	
	float quant = 18.0;
	float tq = floor(iChannelTime[0]*quant)/quant;
	float rang = (tq)*0.1;
	mat2 rotation = mat2(cos(rang), sin(rang),
			   			 -sin(rang), cos(rang));
	
	vec2 coord = uv;
	vec3 dir = vec3((uv-vec2(0.5, 0.2))*3.0, -1.0);
	dir.xy += cs(tq)*0.1;
	
	dir.xz = rotation*dir.xz;
	
	vec4 bg = texture(iChannel1, dir);
	
	vec3 col = vec3(0.0);
	float glow = 0.0;
	vec2 e = vec2(0.1, 0.1) * 0.04;	
	float gx = 0.0, gy = 0.0;
	float push = 5.0;
	
	gx += texture(iChannel0, uv + vec2(-e.x, 0)).r * 1.0 * push;
	gx += texture(iChannel0, uv + vec2(e.x, 0)).r * -1.0 * push;
	gy += texture(iChannel0, uv + vec2(0, -e.x)).r * 1.0 * push;
	gy += texture(iChannel0, uv + vec2(0, e.x)).r * -1.0 * push;
	
	float bg_sob = 0.0;
	bg_sob += texture(iChannel1, dir + vec3(vec2(-e.x, 0), 0.0)).r * 1.0 * push;
	bg_sob += texture(iChannel1, dir + vec3(vec2(e.x, 0), 0.0)).r * -1.0 * push;
	bg_sob += texture(iChannel1, dir + vec3(vec2(0, -e.x), 0.0)).r * 1.0 * push;
	bg_sob += texture(iChannel1, dir + vec3(vec2(0, e.x), 0.0)).r * -1.0 * push;

	glow = gx + gy;
	glow = max(-0.1, glow-0.1);
	
	float ang = atan(gy, gx);
	vec2 surface_dir = vec2(cos(ang), sin(ang));
	float lit = dot(surface_dir, vec2(-1.0))/2.0 + 0.5;
	
	float bg_mix = bg_sob * pow(length(uv2-vec2(0.5, 0.25)), 2.0)*3.0;
	col = vec3(1.0, 0.4, 0.0) * (glow+pow(bg_mix, 2.0));

	fragColor = vec4(col, 1.0);
}