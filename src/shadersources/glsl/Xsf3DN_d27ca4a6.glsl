float noise(vec3 p) //Thx to Las^Mercury
{
	vec3 i = floor(p);
	vec4 a = dot(i, vec3(1., 57., 21.)) + vec4(0., 57., 21., 78.);
	vec3 f = cos((p-i)*acos(-1.))*(-.5)+.5;
	a = mix(sin(cos(a)*a),sin(cos(1.+a)*(1.+a)), f.x);
	a.xy = mix(a.xz, a.yw, f.y);
	return mix(a.x, a.y, f.z);
}
float atan2(float x, float y){
	if(x>0.0)return atan(y/x);
	if(x<0.0&& y>=0.0)return atan(y/x)+3.14;
	if(y<0.0&&x<0.0)return atan(y/x)-3.14;
	if(y>0.0&&x==0.0)return 3.14/2.0;
	if(y<0.0&& x==0.0)return -3.14/2.0;
	return 0.0;
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float R = 100.0;
	
	
	
	
	float t = 200.0*mod(iTime,(iResolution.x-2.0*R)/100.0);
	vec2 move =vec2(t+R,iResolution.y/2.0);
	
	
	if(move.x+R > iResolution.x)
	move.x =iResolution.x-(move.x+R-iResolution.x)-R;
	if(move.x-R < -1.0)
	move.x = -(move.x-R);
	
	//mouse control
	if(iMouse.z > 0.0)move = iMouse.xy;
	
	float x = fragCoord.x - move.x ;
	float y = fragCoord.y - move.y;
	float z = (R-sqrt(abs(x)*abs(x)+ abs(y)*abs(y)));
	vec4 v_pos = vec4(x,y,z,1.0);
	
	vec2 uv = v_pos.xy / iResolution.xy;
	vec3 norm = normalize(vec3(x,y,z));
	float u = move.x/iResolution.x+atan2(norm.z,norm.x)/(2.0*3.14);
	float v = move.y/iResolution.y - 2.0*asin(norm.y)/(2.0*3.14);
	//clamp
	//u = u > 1.0?1.0:u;u = u < .0?.0:u;
	//v = v > 1.0?1.0:v;v = v < .0?.0:v;
	
	//If input channel0
	vec4 f = texture( iChannel0, vec2( u, v) );
	float light = 0.8;
	vec4 light_color =vec4(0.2,0.2,0.2,1.0);
	vec4 mat = f+vec4(noise(vec3(0.2,0.0,0.0)),0.0,0.0,1.0);
	vec4 bkg =  texture( iChannel0, vec2(  fragCoord.x/iResolution.x,1.0-fragCoord.y/iResolution.y) ); 
	
	if(v_pos.x*v_pos.x+v_pos.y*v_pos.y+v_pos.z*v_pos.z - R*R < 1.0)
		fragColor=mat;
	else 
		fragColor = (1.0-light)*bkg+light*light_color;
}