float box(vec3 p) {
	vec3 b = vec3(4.0, 4.0, 4.0);
	p = mod(p,b)-0.5*b;
	
	return length(max(abs(p)-vec3(.5,.5,.5),0.0));
}

vec3 normal(vec3 p) {
	vec3 e = vec3(0.02,.0,.0);
	return normalize(vec3(
		box(p+e.xyy)-box(p-e.xyy),
		box(p+e.yxy)-box(p-e.yxy),
		box(p+e.yyx)-box(p-e.yyx)));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 xy = fragCoord.xy / iResolution.xy - vec2(0.5,0.5);
	xy.y *= -iResolution.y / iResolution.x;

	
	vec3 ro = 2.0*normalize(vec3(cos(iTime),cos(iTime),sin(iTime)));
    vec3 eyed = normalize(vec3(0.0) - ro);
    vec3 ud = normalize(cross(vec3(0.0,1.0,0.0), eyed));
    vec3 vd = normalize(cross(eyed,ud));

	const float fov = 3.14 * 0.7;
	float f = fov * length(xy);
	vec3 rd = normalize(normalize(xy.x*ud + xy.y*vd) + (1.0/tan(f))*eyed);


	vec3 p = ro + rd;

	float d;
	for(int i = 0; i < 42; i++) {
		d = box(p);
		if(d < 0.05) break;
		p += d*rd;
	}

	if(d < 0.05) {
		vec3 n = normal(p);
		fragColor = vec4(abs(n).xyz,1.0);
	}
	else {
		fragColor = vec4(.2,.2,.2,1.0);
	}
		

		
}