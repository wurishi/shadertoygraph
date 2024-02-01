struct Ray
{
	vec3 org;
	vec3 dir;
};

float rayPlaneIntersect( Ray ray, vec4 plane )
{
	float f = dot( ray.dir, plane.xyz );
	
	float t = -( dot( ray.org, plane.xyz ) + plane.w );
	t /= f;
	
	return t;
}

vec3 shade( vec3 pos, vec3 nrm, vec4 light )
{
	vec3 toLight = light.xyz - pos;
	float toLightLen = length( toLight );
	toLight = normalize( toLight );
		
	float diff = dot( nrm, toLight );
	float attn = 1.0 - pow( min( 1.0, toLightLen / light.w ), 2.0 );
	float comb = 2.0 * diff * attn;
	
	return vec3( comb, comb, comb );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// fragCoord: location (0.5, 0.5) is returned 
	// for the lower-left-most pixel in a window
	
	// XY of the normalized device coordinate
	// ranged from [-1, 1]
	vec2 ndcXY = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
	
	// aspect ratio
	float aspectRatio = iResolution.x / iResolution.y;
	
	// scaled XY which fits the aspect ratio
	vec2 scaledXY = ndcXY * vec2( aspectRatio, 1.0 );
	
	// camera XYZ in world space
	vec3 camWsXYZ = vec3( 0.0, 1.0, 0.0 );
	camWsXYZ.z += 10.0 * cos( iTime );
	
	// construct the ray in world space
	Ray ray;
	ray.org = camWsXYZ;
	ray.dir = vec3( scaledXY, -2.0 ); // OpenGL is right handed
	
	// define the plane in world space
	vec4 plane = vec4( 0.0, 1.0, 0.0, 0.0 );
	
	float t = rayPlaneIntersect( ray, plane );
	
	// define the point light in world space (XYZ, range)
	vec4 lightWs = vec4( 0.0, 5.0, -5.0, 10.0 );
	
	if ( t >= 0.0 )
	{
		vec3 sceneWsPos = ray.org + t * ray.dir;
		vec3 sceneWsNrm = plane.xyz;
		vec2 sceneUV = sceneWsPos.xz / 4.0;
		
		vec4 sceneBase = texture( iChannel0, sceneUV );		
		vec3 sceneShade = shade( sceneWsPos, sceneWsNrm, lightWs );
		
		fragColor = vec4( sceneShade * sceneBase.xyz, 1.0 );
	}
	else
	{
		fragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
	}
}