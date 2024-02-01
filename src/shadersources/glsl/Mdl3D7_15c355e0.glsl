float atan2(float x, float y )
{
	return atan( x, y );
}

vec3 rgb2hsv( const vec3 in_rgb )
{
	float u = (2.0 * in_rgb.r - in_rgb.g - in_rgb.b)   / 3.0;
	float v = ( -in_rgb.r + 2.0 * in_rgb.g - in_rgb.b) / 3.0;

	vec3 out_hsv;
	out_hsv.y = sqrt(u*u + v*v);
	out_hsv.x = (out_hsv.y>0.0) ? atan2(u,v) : 0.0;
	out_hsv.z = dot( vec3(0.3333333), in_rgb);

	return out_hsv;
}

vec3 hsv2rgb( vec3 in_hsv )
{
	float u = in_hsv.y * sin(in_hsv.x);
	float v = in_hsv.y * cos(in_hsv.x);

	vec3 out_rgb;
	out_rgb.r = in_hsv.z + u;
	out_rgb.g = in_hsv.z + v;
	out_rgb.b = clamp( in_hsv.z - u - v, 0.0, 1.0 );

	return out_rgb;
}


vec3 BayDidIt( const vec3 in_col )
{
	const float orangeHue = 2.0 * 3.14159265 * 0.22;
	const float tealHue = 2.0 * 3.14159265 * 0.78;
	vec2 vorange = vec2( cos(orangeHue), sin(orangeHue) );
	vec2 vteal   = vec2( cos(tealHue), sin(tealHue) );
	
	vec2 vdiff = normalize(vteal - vorange);
	
	vec3 hsv = rgb2hsv( in_col );
	vec2 v = vec2( cos(hsv.x), sin(hsv.x) );
	float t = dot( v, vdiff );
	hsv.x = mix( orangeHue, tealHue, t*0.5+0.5);
	
	return hsv2rgb( hsv );
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	//uv.y = 1.0-uv.y;
	vec3 rgb = texture( iChannel0, vec2(uv.x,1.0-uv.y) ).rgb;
	
	//note: test-pattern
	if ( uv.y < 0.2 )
	{
		float h = uv.x * 3.14159265 * 2.0;
		rgb = hsv2rgb( vec3(h,1,0.25) );
	}
	if ( uv.y > 0.1 )
	{
		rgb = BayDidIt( rgb );
	}
	
	vec4 outcol = vec4( 0, 0, 0, 1 );		
	outcol.rgb = rgb;
		
	fragColor = vec4( outcol );
}
