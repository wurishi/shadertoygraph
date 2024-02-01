// A classic plasm shader. (c) Ajarus, viktor@ajarus.com; 1996.
//
// Attribution-ShareAlike CC License.

//----------------
  const int ps = 0; // play with values 0..10
//----------------


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
   float x = fragCoord.x / iResolution.x * 640.;
   float y = fragCoord.y / iResolution.y * 480.;
   
	if (ps > 0)
	{
	   x = float(int(x / float(ps)) * ps);
	   y = float(int(y / float(ps)) * ps);
	}
	
   float mov0 = x+y+sin(iTime)*10.+sin(x/90.)*70.+iTime*2.;
   float mov1 = (mov0 / 5. + sin(mov0 / 30.))/ 10. + iTime * 3.;
   float mov2 = mov1 + sin(mov1)*5. + iTime*1.0;
   float cl1 = sin(sin(mov1/4. + iTime)+mov1);
   float c1 = cl1 +mov2/2.-mov1-mov2+iTime;
   float c2 = sin(c1+sin(mov0/100.+iTime)+sin(y/57.+iTime/50.)+sin((x+y)/200.)*2.);
   float c3 = abs(sin(c2+cos((mov1+mov2+c2) / 10.)+cos((mov2) / 10.)+sin(x/80.)));
  
   float dc = float(16-ps);
	
	if (ps > 0)
	{
   		cl1 = float(int(cl1*dc))/dc;
   		c2 = float(int(c2*dc))/dc;
   		c3 = float(int(c3*dc))/dc;
	}
	
   fragColor = vec4( cl1,c2,c3,1.0);
}