// Adapted from http://strlen.com/gfxengine/fisheyequake/
vec3 fisheye_lookup(float fov, vec2 position)
{
	vec2 d = position - 0.5;
	
	float yaw = sqrt(d.x*d.x+d.y*d.y) * fov;

	float roll = -atan(d.y, d.x);
	float sx = sin(yaw) * cos(roll);
	float sy = sin(yaw) * sin(roll);
	float sz = cos(yaw);	

	return vec3(sx, sy, sz);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float fov = abs(sin(iTime * 0.2)) * 720.0 * 3.14  / 180.0;
	vec3 fisheye_coords = fisheye_lookup(fov, fragCoord.xy/iResolution.xy);
		
	float modlength = 15.7;
	float modtime = mod(iTime, modlength * 3.0);

	vec3 color = vec3(0);
	
	if(modtime > modlength*0.0 && modtime <= modlength*1.0)
		color = texture(iChannel0, -fisheye_coords).rgb;
	
	if(modtime > modlength*1.0 && modtime <= modlength*2.0)
		color = texture(iChannel1, -fisheye_coords).rgb;
	
	if(modtime > modlength*2.0 && modtime <= modlength*3.0)
		color = texture(iChannel2, -fisheye_coords).rgb;
	
	fragColor = vec4(color, 1.0); 
}