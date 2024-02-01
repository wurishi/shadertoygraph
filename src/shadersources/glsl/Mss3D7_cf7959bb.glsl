#define PI (3.141592653589793238462643383)
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv=((fragCoord.xy/iResolution.xy)-vec2(0.5,0.5))*2.0;
	uv.y=abs(uv.y);
	fragColor=texture(iChannel0,fract(vec2((uv.x/uv.y)+(sin(iTime*PI*0.25)*2.0),
												(1.0/uv.y)+(cos(iTime*PI*0.3)*2.0))))*uv.y;
}		
