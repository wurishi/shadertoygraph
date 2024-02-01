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
	
	float R = 200.0;
	//If input channel0
	//float f = texture( iChannel0, vec2( fragCoord.x/iResolution.x,0) ).y;
	//R = 200.0*f;
	
	
	
	float t =200.0*iTime;
	float x = fragCoord.x- iMouse.x;
	float w =0.7;
	float y = iMouse.y+ R*sin(w*(x+t)/180.0*3.14);
	if(  (abs(y*cos(x)-fragCoord.y)+noise(vec3(10,y,10))) < 2.0 )
		fragColor = vec4(cos(w*x/180.0*3.14)+0.5,sin(w*x/180.0*3.14)+0.5,sin(w*x/180.0*3.14)+0.5,1.0);
	else fragColor = vec4(0.0);
	if(  (abs((fragCoord.y-y)*cos(x)-fragCoord.y)+noise(vec3(10,y,10))) < 2.0)
		fragColor = vec4(cos(w*x/180.0*3.14)+0.5,sin(w*x/180.0*3.14)+0.5,sin(w*x/180.0*3.14)+0.5,1.0);
	
}