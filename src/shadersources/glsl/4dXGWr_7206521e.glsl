/* What I'd like to do next is treat the color values from the texture
   as surface normals, and do diffuse shading accordingly.
   Maybe also keep the colors as colors.
To do:
- apply simple averaging or gaussian filter to smooth out the normals 
- apply specular reflection */

vec3  s = normalize(vec3(5.0, -1.0, 5.0)); // light direction
float texelSize = 1.0 / 1024.0;

vec3 blur(vec2 uv) {
	vec2 x = vec2(texelSize, 0.0);
	vec2 y = vec2(0.0, texelSize);
	return (texture(iChannel0, uv).xyz * 2.0 +
			texture(iChannel0, uv + x).xyz +
			texture(iChannel0, uv - x).xyz +
			texture(iChannel0, uv + y).xyz +
			texture(iChannel0, uv - y).xyz) * (1.0 / 6.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xx;
	vec2 uv2 = uv + vec2(sin(iTime + uv.y * 10.0) * 0.2,
					cos(iTime + uv.x * 10.0) * 0.2);
	
	vec3 col = texture(iChannel0, uv2).xyz;
	vec3 n = normalize(blur(uv2) - 0.5);
	
	float dot1 = dot(s, n);
	vec3 r = -s + 2.0 * dot1 * n;
	float diffuse = max(dot1, 0.0);
	
	vec3 v = normalize(vec3(-uv.x, -uv.y, 2.0)); // viewer angle
	float spec = pow(dot(r, v), 16.0);
	
	fragColor = vec4(vec3(0.1 +
							 col * 0.4 +
							 diffuse * 0.4 +
							 spec * 3.0), 1.0);
}