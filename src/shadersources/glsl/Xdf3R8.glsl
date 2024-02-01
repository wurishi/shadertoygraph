void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	float time = iTime;
	vec3 p = (vec3(fragCoord,.0) / iResolution - 0.5) * abs(sin(time/10.0)) * 50.0;
	float d = sin(length(p)+time), a = sin(mod(atan(p.y, p.x) + time + sin(d+time), 3.1416/3.)*3.), v = a + d, m = sin(length(p)*4.0-a+time);
	fragColor = vec4(-v*sin(m*sin(-d)+time*.1), v*m*sin(tan(sin(-a))*sin(-a*3.)*3.+time*.5), mod(v,m), time);
}