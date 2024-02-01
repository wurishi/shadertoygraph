#define M_PI	3.141593

vec2 tunnel(in vec2 pix, out float z);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec3 color = vec3(1.0, 1.0, 1.0);
	
	vec2 tc = fragCoord.xy / iResolution.xy;
	
	float z;
	vec2 tun = tunnel(tc, z);
	
	color = vec3(clamp(2.0 / z, 0.0, 1.0)) * texture(iChannel0, tun).xyz;

	fragColor.xyz = color;
	fragColor.w = 1.0;
}

float psin(float x)
{
	return sin(x) * 0.5 + 0.5;
}

vec2 tunnel(in vec2 pix, out float z)
{
	float aspect = iResolution.x / iResolution.y;
	vec2 center = vec2(cos(iTime * 0.15), 0.0);
	vec2 pt = (pix * 2.0 - 1.0) * vec2(aspect, 1.0);
	
	vec2 dir = pt - center;
	
	float angle;
	angle = atan(dir.y, dir.x) / M_PI;
	float dist = sqrt(dot(dir, dir));
	z = 2.0 / dist;	

	return vec2(angle * 2.0 + iTime * 0.25, z + iTime * 0.5);
}