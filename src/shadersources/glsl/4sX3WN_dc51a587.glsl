void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 vid = texture(iChannel0, fragCoord.xy / iResolution.xy).rgb;
	float v = vid.r+vid.g+vid.b;
	float w = sin(iTime*4.0)*13.0;
	
	vec2 n = vec2(dFdx(v) * w, dFdy(v) * w);
	float t = sqrt(dot(n,n));
	
	fragColor = vec4(vid*.4+(vid * vid*vec3(n.x, n.y, n.x*n.y))*t,1.0);
}