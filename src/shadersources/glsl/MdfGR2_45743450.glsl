void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float tempy = iResolution.y/30.0;
	float tempx = iResolution.x/60.0;

	vec4 col = vec4(uv,0.5+0.5*sin(iTime),1.0);

    vec2 coord = fragCoord;
	
	float t = iTime/100.0;
	
	
	coord.xy+=float(iTime)*50.0;
	coord.y+=sin(mod(t,0.5)*coord.x/20.0)*50.0;
	coord.x+=cos(mod(t,0.5)*coord.y/20.0)*20.0;

	if(mod(coord.y,tempy)<2.0)
	{
		col/=100.0;
	}
	else if(mod(coord.x,tempx)<2.0)
	
	{
		col/=100.0;
		
	}
	
	col.y*=texture(iChannel0,2.0*cos(t*3.0)*uv).y;
	col.x+=texture(iChannel3,uv).x;	
	fragColor = col;
}