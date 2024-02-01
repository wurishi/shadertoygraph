float noise(vec3 p) //Thx to Las^Mercury
{
	vec3 i = floor(p);
	vec4 a = dot(i, vec3(1., 57., 21.)) + vec4(0., 57., 21., 78.);
	vec3 f = cos((p-i)*acos(-1.))*(-.5)+.5;
	a = mix(sin(cos(a)*a),sin(cos(1.+a)*(1.+a)), f.x);
	a.xy = mix(a.xz, a.yw, f.y);
	return mix(a.x, a.y, f.z);
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	//Find edge
	vec4 f = texture(iChannel0,vec2(fragCoord.x/iResolution.x,fragCoord.y/iResolution.y));
	vec4 f1 = texture(iChannel0,vec2((fragCoord.x-2.0)/iResolution.x,(fragCoord.y-2.0)/iResolution.y));
	vec4 f2 = texture(iChannel0,vec2((fragCoord.x-2.0)/iResolution.x,fragCoord.y/iResolution.y));
	vec4 f3 = texture(iChannel0,vec2(fragCoord.x/iResolution.x,(fragCoord.y-2.0)/iResolution.y));
	vec4 m = (f+f1+f2+f3)/4.0;
	vec4 var =(sqrt((f-m)*(f-m)+(f1-m)*(f1-m)+(f2-m)*(f2-m)+(f3-m)*(f3-m))/2.0);
	float thre = 0.04;
	
	//mouse
	float R = 100.0;
	float x = fragCoord.x-iMouse.x;
	float y = fragCoord.y-iMouse.y;
	if(length(var) > thre)
			fragColor = var;
	else
		fragColor = vec4(0.0);
	if(iMouse.z >0.0 && x*x+y*y<R*R)
			fragColor = f;
	//Auto scan
	float div = 10.0;
	float t = mod(iTime,10.0);
	if(iTime < div && iMouse.z <=0.0 && fragCoord.x > t/div*iResolution.x)
		fragColor = f;
	//Original view
	float w = 100.0;
	float h = 100.0;
	vec4 preview = texture(iChannel0,vec2((fragCoord.x-(iResolution.x-w))/w,fragCoord.y/h));
	if(fragCoord.x > iResolution.x - w && fragCoord.y < h){
		fragColor = preview;
	}
}