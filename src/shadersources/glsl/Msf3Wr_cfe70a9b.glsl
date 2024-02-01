//by mu6k
//License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//
//muuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuusk!

float hash(float x)
{
	return fract(sin(cos(x*12.13)*19.123)*17.321);
}


float noise(vec2 p)
{
	vec2 pm = mod(p,1.0);
	vec2 pd = p-pm;
	float v0=hash(pd.x+pd.y*41.0);
	float v1=hash(pd.x+1.0+pd.y*41.0);
	float v2=hash(pd.x+pd.y*41.0+41.0);
	float v3=hash(pd.x+pd.y*41.0+42.0);
	v0 = mix(v0,v1,smoothstep(0.0,1.0,pm.x));
	v2 = mix(v2,v3,smoothstep(0.0,1.0,pm.x));
	return mix(v0,v2,smoothstep(0.0,1.0,pm.y));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy-iResolution.xy*.5) / iResolution.y;
	
	float rot=sin(iTime*0.3)*sin(iTime*0.4)*0.2;
		
	uv *= mat2(cos(rot),-sin(rot),sin(rot),cos(rot));
    
	float v =0.0;
	
	for (float i = 0.0; i<12.0; i+=1.0)
	{
		float t = mod(iTime+i,12.0);
		float l = iTime-t;
		float e = exp2(t);
		v+=noise(uv*e+vec2(cos(l)*53.0,sin(l)*100.0))*(1.0-(t/12.0))*(t/12.0);
		
	}
	
	v-=0.5;
	
	vec3 color = vec3(v);

	fragColor = vec4(color,1.0);
}
