#define SAMPLE 16
#define LEVEL 5 // log(iChannelResolution/16)/log(2)

#define MODE 0 // 0 for barycenter   1 for max

//int textureLogRes = int(log(iChannelResolution[0].xy/16)/log(2.));

vec2 findTextureCenter()
{	
	vec2 g = vec2(0.); float vtot=0.;
	vec2 gmax = vec2(0.); float vmax=-1.;
	for (int j=0; j< SAMPLE; j++)
	  for (int i=0; i< SAMPLE; i++)
	  {
		  vec2 pos = (.5+vec2(i,j))/float(SAMPLE);
		  float v = texture(iChannel0,pos,float(LEVEL)).r;
		  v = clamp(2.*(v-.5),0.,1.);
		  v = pow(v,2.);
		  g    += pos*v;
		  vtot += v;
		  if (v>vmax)
		     { vmax= v; gmax = pos;  }
			  
	  }
#if MODE==1
	return gmax;
#else
	return g/vtot;		 
#endif
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 offset = findTextureCenter()-.0;
	vec4 col = texture(iChannel0,(uv-.5)/8.+offset);
	//col = ((col-.5)*2.-.2)/.6;
	fragColor = col;
}