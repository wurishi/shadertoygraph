float PI = 3.14159265358979323846264;

vec2 warp(in vec2 xy)
{
	float amount = 0.3*pow(sin(iTime*2.0), 20.0);
	return vec2(xy.x + sin(xy.x*10.0)*amount*sin(iTime),
				xy.y + cos(xy.y*10.0)*amount*sin(iTime));
}

float dis(in vec2 uv, in float x, in float y)
{
	return sqrt(pow(abs(uv.x - x), 2.0) + pow(abs(uv.y - y), 2.0));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = warp(uv);
	
	float x_1 = sin(iTime*1.5);
	float y_1 = cos(iTime);
	float x_2 = cos(iTime);
	float y_2 = sin(iTime);
	
	float dist_1 = dis(uv, x_1, y_1);
	float dist_2 = dis(uv, x_2, y_2);
	
	float t = sin(iTime);//mod(iTime*100.0, 100.0)/100.0;
	float c1 = sin(dist_1*50.0) * sin(dist_2*50.0);
	float red = c1*t;
	float blue = sin(dist_1*50.0) * sin(dist_1*150.0);
	float green = c1*(1.0-t);
	vec3 color = vec3(red, green, blue);
	
	vec3 flash = vec3(pow(sin(iTime*2.0),20.0));
	color += flash;
	fragColor = vec4(color, 1.0);
}
