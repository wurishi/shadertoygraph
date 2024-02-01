float f( const float x, const float z )
{
	return .2;
}

bool castRay( const vec3 ro, const vec3 rd )
{
    const float delt = 1.0;
    const float mint = 0.0;
    const float maxt = 20.0;
    for( float t = mint; t < maxt; t += delt )
    {
        vec3 p = ro + rd*t;
        if( p.y < f( p.x, p.z ) )
        {
            return true;
        }
    }
    return false;
}

vec3 terrainColor()
{
	return vec3(1.0,0.86, 0.69);
}

vec3 skyColor()
{
	return vec3(.82,0.84,0.85);
}
  
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 norm_coord = fragCoord.xy / iResolution.xy;

	vec3 eye = vec3(norm_coord, 0.0);
	vec3 dir = vec3(0.0, -0.02,0.0);

	if (castRay(eye,dir))
	{
		fragColor = vec4(terrainColor(), 1.0);
	}
	else
	{
		fragColor = vec4(skyColor(), 1.0);
	}
}