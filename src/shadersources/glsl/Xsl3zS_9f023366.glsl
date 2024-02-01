// by maq/floppy
vec3 flower(vec2 p, float m)
{
   	vec3 col=vec3(0.0);
   	p -= vec2(1.5-0.2*sin(iTime*m),1.5);
   	float r = sqrt(dot(p,p));
   	float f=1.1;
   	float listki=5.0;
  	float at = atan(p.y/p.x);
   	float phi =  at+(sin(iTime*m)-sin(iTime*m+0.4)*sin(r));
	float phi2 = at+sin(iTime*m*1.0+0.3)-sin(iTime*m*1.0+0.6)*sin(r);

  	if(r<exp(r*2.6)*0.1+(0.01+abs(sin(listki*phi)))) 
      f=r;           
   	else
      col = mix( vec3(0.9,0.9,0.9), vec3(0.9,0.7,0.7),f) ;

   	if(r<0.1+abs(sin(listki*phi2+(1.0+sin(iTime))*0.5)))
   	{   
   	  f = r; 
      col = mix( vec3(0.97+0.0025*m,0.97+0.0025*m,0), vec3(1,1,1), 10.0*f) ;
   	}
   	return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = 1.4*fragCoord.xy / iResolution.xy;
	p.y*=0.8;
	p.x-=0.1;
	vec2 cp=p-vec2(1.1,0.5);
	vec3 col = 0.01*vec3(0.2/dot(cp,cp),0.2/dot(cp,cp),0.1/dot(cp,cp));
   	col += flower((p.xy+vec2(0,0))*4.2,2.5);   
   	col += flower((p.xy+vec2(-0.45,-0.4))*4.5,3.2);   
   	col += flower((p.xy+vec2(0.13,-0.4))*4.1,3.0);   
   	col += flower((p.xy+vec2(-0.6,-0.1))*8.2,3.1);   
	fragColor = vec4(col,1.0);	
}