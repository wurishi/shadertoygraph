
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy - 0.5;
	
	float d = 0.0;
	for (int i=0; i<50; i++)
	{
		float speed = sin(0.1+float(i)/20.0)*1.0;
		float fi = float(i);
		vec3 pos = speed*sin( iTime*speed*vec3(0.5,0.9,0.75)+fi );

		d += pow(clamp((1.0-abs(distance(vec3(uv.x,uv.y,0.0), pos))),0.0,1.0),30.0);
	}
	
	d += pow(clamp((1.0-abs(distance(vec3(uv.x,uv.y,0.0), vec3(uv.x,0.6,0.0)))),0.0,1.0),30.0);
	d += pow(clamp((1.0-abs(distance(vec3(uv.x,uv.y,0.0), vec3(uv.x,-0.6,0.0)))),0.0,1.0),30.0);
	d += pow(clamp((1.0-abs(distance(vec3(uv.x,uv.y,0.0), vec3(0.6,uv.y,0.0)))),0.0,1.0),30.0);
	d += pow(clamp((1.0-abs(distance(vec3(uv.x,uv.y,0.0), vec3(-0.6,uv.y,0.0)))),0.0,1.0),30.0);
	
	
	d = clamp(d,0.0,0.0125)*60.0;
	
	float noise = 1.0; //0.2*sin(uv.y*1800.0)+1.0-2.0*abs(uv.x);	
	
	fragColor = vec4(1.75,1.75,1.5,1.0)*d*noise;
}