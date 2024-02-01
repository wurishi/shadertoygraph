/*
	"Stunnel" by Tick of Excess
	
	Contribution to Solskogen Shardertoy compo, Solskogen 2013

	Seems to be bugging hard in Firefox. Works as expected in Chrome.
	
*/
vec4 tunnel(vec2 coor, vec3 origin, float d)
{
	float rad = 1.0;
	vec2 uv;
	
	vec3 direction = vec3(coor.x, coor.y, 1.0);
	direction = normalize(direction);
		
	float a = pow(direction.x, 2.0) + pow(direction.y, 2.0);
	float b = 2.0 * (origin.x*direction.x + origin.y * direction.y);
	float c = pow(origin.x, 2.0) + pow(origin.y, 2.0) - pow(rad, 2.0);
	
	float delta = pow(b, 2.0) - 4.0 * a * c;
	
	if(delta < 0.0)
	{
		return texture(iChannel0, vec2(0.5, 0.5));
	}
	
	float t1 = (-b + sqrt(delta)) / (2.0 * a);
	float t2 = (-b - sqrt(delta)) / (2.0 * a);
	
	float t = min(t1, t2);
	
	vec3 intersection = origin + direction * t;
	
	float u = abs(intersection.z*0.2*sin(d/4.0)) + iTime;
	float v = abs(atan(intersection.y, intersection.x)/3.1415926);
	v = v + abs(sin(u));
	return texture(iChannel0, vec2(u, v));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 n_pos = (fragCoord.xy - iResolution.xy/2.0) / iResolution.xy;
	n_pos = n_pos + vec2(cos(iTime/1.1)/1.9, sin(iTime/1.3)/1.9);

	fragColor = tunnel(n_pos, vec3(sin(iTime/1.01)/1.5, cos(iTime/1.03)/1.5, -1.0), iTime);
}
