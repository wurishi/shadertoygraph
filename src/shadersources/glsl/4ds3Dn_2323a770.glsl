const int NUMPOINTS=18;
const int XPOINTS=6;
const int YPOINTS=3;
const float RADIUS=20.0;	
const float POINTSIZE=10.0;
vec2 points[NUMPOINTS];

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 fragcol;
	bool is_point=false;
	float xstep,ystep;
	xstep=iResolution.x/float(XPOINTS);
	ystep=iResolution.y/float(YPOINTS);
	for(int i=0;i<XPOINTS;i++)
	{
		for(int j=0;j<YPOINTS;j++)
		{
			points[i*YPOINTS+j]=vec2(float(i)*xstep+100.0,float(j)*ystep+100.0);
	
		}
	}

	
	for(int i=0;i<NUMPOINTS;i++)
	{
		
		float sgn=1.0;
		
		if(mod(float(i),4.0)==0.0)
		{
			
			points[i]=points[i]+sgn*vec2(float(i+1)*20.0*(cos(1.0*iTime)-pow(cos(2.0*iTime),3.0)),float(i+1)*10.0*(sin(1.0*iTime)-pow(sin(3.0*iTime),3.0)));
	
		}
		else if(mod(float(i),4.0)==1.0)
		{
			sgn=-1.0;
			points[i]=points[i]+sgn*vec2(float(i+1)*5.0*(cos(7.0*iTime)-pow(cos(1.0*iTime),4.0)),float(i+1)*5.0*(sin(7.0*iTime)-pow(sin(1.0*iTime),3.0)));
		}
		else if(mod(float(i),4.0)==2.0)
		{
			points[i]=points[i]+sgn*vec2(float(i+1)*10.0*(cos(1.0*iTime)-pow(cos(3.0*iTime),5.0)),float(i+1)*5.0*(sin(3.0*iTime)-pow(sin(1.0*iTime),3.0)));
		}
		else if(mod(float(i),4.0)==3.0)
		{
			points[i]=points[i]+sgn*vec2(float(i+1)*3.0*(cos(4.0*iTime)-pow(cos(1.0*iTime),6.0)),float(i+1)*5.0*(sin(4.0*iTime)-pow(sin(1.0*iTime),3.0)));
		}
	}

	float mindist=50000.0;
	float second_mindist=50000.0;
	float minpoint=-1.0;
	float p_dist;
	for(int i=0;i<NUMPOINTS;i++)
	{
		p_dist=distance(fragCoord.xy,points[i]);
		
		if(p_dist<mindist)
		{
			minpoint=float(i);
			mindist=p_dist;
		}
		else if(p_dist<second_mindist)
		{
			second_mindist=p_dist;
		}
	}


	fragcol=vec4(sin(iTime),(abs(sin(iTime))*200.0-mindist)/(abs(sin(iTime))*200.0*1.0),0.0,1.0);
	
	
	fragColor = fragcol;
}