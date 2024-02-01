void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 uvLine1 = vec2(uv.x,iTime/10.0);
	vec4 tmp = texture(iChannel1,uvLine1);
	vec4 tmp2 = texture(iChannel0,uv);
	if (tmp.g > uv.y)
		fragColor = tmp2;// vec4(uv.x,uv.y,0,1);
	else
		fragColor = vec4(1,1,1,1);
}