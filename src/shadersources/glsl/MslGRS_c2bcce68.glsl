// hq4x filter
// Ripped from https://github.com/libretro/common-shaders/blob/master/hqx/hq4x.cg

const float SEG = 40.0 / 256.0;
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv =  vec2(SEG,-1.0) * fragCoord.xy / iResolution.xy;
	uv.y++;
	uv.x += SEG*float(int(mod(iTime * 10.0, 6.0)));
	
	float mx = 1.0; // start smoothing wt.
 	const float k = -1.10; // wt. decrease factor
 	const float max_w = 0.75; // max filter weigth
 	const float min_w = 0.03; // min filter weigth
 	const float lum_add = 0.33; // effects smoothing
	
	vec4 color = texture(iChannel0, uv);
	   vec3 c = color.xyz;
		
	
	   float x = 0.5 * (1.0 / 256.0);
	   float y = 0.5 * (1.0 / 32.0);
	
		const vec3 dt = 1.0*vec3(1.0, 1.0, 1.0);
	
	   vec2 dg1 = vec2( x, y);
	   vec2 dg2 = vec2(-x, y);
	
	   vec2 sd1 = dg1*0.5;
	   vec2 sd2 = dg2*0.5;
	
	   vec2 ddx = vec2(x,0.0);
	   vec2 ddy = vec2(0.0,y);
	
		vec4 t1 = vec4(uv-sd1,uv-ddy);
		vec4 t2 = vec4(uv-sd2,uv+ddx);
		vec4 t3 = vec4(uv+sd1,uv+ddy);
		vec4 t4 = vec4(uv+sd2,uv-ddx);
		vec4 t5 = vec4(uv-dg1,uv-dg2);
		vec4 t6 = vec4(uv+dg1,uv+dg2);
			
	   vec3 i1 = texture(iChannel0, t1.xy).xyz;
	   vec3 i2 = texture(iChannel0, t2.xy).xyz;
	   vec3 i3 = texture(iChannel0, t3.xy).xyz;
	   vec3 i4 = texture(iChannel0, t4.xy).xyz;
	
	   vec3 o1 = texture(iChannel0, t5.xy).xyz;
	   vec3 o3 = texture(iChannel0, t6.xy).xyz;
	   vec3 o2 = texture(iChannel0, t5.zw).xyz;
	   vec3 o4 = texture(iChannel0, t6.zw).xyz;
	
	   vec3 s1 = texture(iChannel0, t1.zw).xyz;
	   vec3 s2 = texture(iChannel0, t2.zw).xyz;
	   vec3 s3 = texture(iChannel0, t3.zw).xyz;
	   vec3 s4 = texture(iChannel0, t4.zw).xyz;
	
	   float ko1 = dot(abs(o1-c),dt);
	   float ko2 = dot(abs(o2-c),dt);
	   float ko3 = dot(abs(o3-c),dt);
	   float ko4 = dot(abs(o4-c),dt);
	
	   float k1=min(dot(abs(i1-i3),dt),max(ko1,ko3));
	   float k2=min(dot(abs(i2-i4),dt),max(ko2,ko4));
	
	   float w1 = k2; if(ko3<ko1) w1*=ko3/ko1;
	   float w2 = k1; if(ko4<ko2) w2*=ko4/ko2;
	   float w3 = k2; if(ko1<ko3) w3*=ko1/ko3;
	   float w4 = k1; if(ko2<ko4) w4*=ko2/ko4;
	
	   c=(w1*o1+w2*o2+w3*o3+w4*o4+0.001*c)/(w1+w2+w3+w4+0.001);
	   w1 = k*dot(abs(i1-c)+abs(i3-c),dt)/(0.125*dot(i1+i3,dt)+lum_add);
	   w2 = k*dot(abs(i2-c)+abs(i4-c),dt)/(0.125*dot(i2+i4,dt)+lum_add);
	   w3 = k*dot(abs(s1-c)+abs(s3-c),dt)/(0.125*dot(s1+s3,dt)+lum_add);
	   w4 = k*dot(abs(s2-c)+abs(s4-c),dt)/(0.125*dot(s2+s4,dt)+lum_add);
	
	   w1 = clamp(w1+mx,min_w,max_w);
	   w2 = clamp(w2+mx,min_w,max_w);
	   w3 = clamp(w3+mx,min_w,max_w);
	   w4 = clamp(w4+mx,min_w,max_w);
	
	color = vec4((w1*(i1+i3)+w2*(i2+i4)+w3*(s1+s3)+w4*(s2+s4)+c)/(2.0*(w1+w2+w3+w4)+1.0), 1.0);
	float split = clamp(5.0*sin(4.0*iTime-4.0)*0.5 + 2.5, 0.0, 1.0);
	color.xyz = split * color.xyz + (1.0-split) * texture(iChannel0, uv).xyz;
	fragColor = color; //texture(iChannel0, uv);
}