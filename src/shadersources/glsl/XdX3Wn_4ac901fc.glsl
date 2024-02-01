// Rebb/TRSi^Paradise 

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float an= sin(iTime)/3.14157;
    float as= sin(an);
    float zoo = .23232+.38*sin(.7*iTime);

    vec2 position = ( fragCoord.xy / iResolution.xy *3.3 );

	float color = 0.0;
	color += sin(position.x - position.y) ;
	color += sin(iTime)* cos(sin(iTime)*position.y*position.x*sin(position.x))+.008;
	color += sin(iTime)+position.x*sin(position.y*sin(sin(tan(cos (iTime)))));
	fragColor = vec4( vec3(sin(color*color)*4.0, sin(color*color) , color )*sin(iTime+position.x/(iTime*3.14)),iTime/10.828 );

}