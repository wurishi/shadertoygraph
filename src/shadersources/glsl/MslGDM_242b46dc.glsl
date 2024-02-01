#define INTENSITY 5.5
#define GLOW 2.0

vec2 blob(vec2 uv, vec2 speed, vec2 size, float time) {
	vec2 point = vec2(
		(sin(speed.x * time) * size.x),
		(cos(speed.y * time) * size.y)
	);

	float d = 1.0 / distance(uv, point);
	d = pow(d / INTENSITY, GLOW);
	
	//if( d < 0.1 )	
	//	return uv;
	
	vec2 v2 = normalize(uv - point) * clamp(d,0.1,0.7);
	
	
	return uv - v2;
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = -1.0 + 2.0 * (fragCoord.xy / iResolution.xy);
	
	float time = iTime * 0.75;
	
	vec2 read = blob(uv, vec2(3.7, 5.2), vec2(0.2, 0.2), time);
	
	
	vec4 pixel = texture(iChannel0, read);
	
	//if( blob < 0.1 ) pixel = vec4(pixel.r*0.5,pixel.g*0.5,pixel.b*0.5,1);
	
	
	fragColor = pixel;
}