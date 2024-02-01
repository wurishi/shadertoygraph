#define _PI 3.1415926535897932384626433832795


vec2 getPixelShift(vec2 center,vec2 pixelpos,float startradius,float size,float shockfactor, in vec2 fragCoord)
{
	float m_distance = distance(center,pixelpos);
	if( m_distance > startradius && m_distance < startradius+size )
	{
		float sin_dist = sin((m_distance -startradius)/size* _PI )*shockfactor;
		return ( pixelpos - normalize(pixelpos-center)*sin_dist )/ iResolution.xy;
	}
	else 
		return fragCoord.xy / iResolution.xy;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 shockcenter1 = vec2(iResolution.x/4.0,iResolution.y/4.0*3.0);

    vec2 shockcenter2 = vec2(iResolution.x/4.0*3.0,iResolution.y/4.0);

    float startradius = mod(iTime , 1.0) *600.0;
	float size = mod(iTime , 1.0) *200.0;
	float shockfactor = 50.0-mod(iTime , 1.0)*50.0;
	
	vec2 total_shift = getPixelShift(shockcenter1,fragCoord.xy,startradius,size,20.0,fragCoord) + 
                       getPixelShift(shockcenter2,fragCoord.xy,startradius,size,20.0,fragCoord);
	fragColor = texture(iChannel0,total_shift);
	
}