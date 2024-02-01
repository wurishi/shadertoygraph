// Rebb/TRSi^Paradise 
// Heavily based on work by IQ
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
float an= sin(iTime)/3.14157;
float as= sin(an);
float zoo = .23232+.38*sin(.7*iTime);

    vec2 p = (1.7+an)*fragCoord.xy / iResolution.xy ;  
 
 vec2 z, c;
    vec2 uv; 	
    c.x = p.x * sin(2.0)+an;
    c.y = p.y *sin(2.0)-an;
    		
    int i;
    z = c;
	  
	  for( int i=0; i<38;i++ )
{	

        float x = (z.x * z.x - z.y * z.y *zoo ) + c.x;
        float y = (z.y * z.x + z.x * z.y *zoo) + c.y;
	uv.x = x ;
	uv.y = y ;
	         
	z.x = x+as;
	z.y = y+as;    

}

 vec3 col = texture( iChannel0,uv ).zyx;
  fragColor = vec4(col,1.0);
}