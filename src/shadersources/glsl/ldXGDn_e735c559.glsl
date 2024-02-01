void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv=fragCoord.xy/iResolution.xy;
	float s1=texture(iChannel0,vec2(uv.x,1.0)).x;
	float s2=texture(iChannel0,vec2(uv.y,1.0)).x;
	vec3 col=vec3(
	(texture(iChannel0,vec2(0.0,0.1)).x-0.5)*2.0,
	(texture(iChannel0,vec2(0.0,0.2)).x-0.5)*2.0,
	1.0);
	if(abs(s1-s2)<0.1) fragColor=vec4(vec3(1.0-abs(s1-s2)/0.1)*col,1.0);
	else fragColor=vec4(vec3(0.0),1.0);
}