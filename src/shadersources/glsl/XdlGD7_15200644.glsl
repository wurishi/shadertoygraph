void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	fragColor = vec4(uv,abs(cos(iTime *0.5)) + sin( iTime * uv.x / abs(sin(3.0 * uv.y / iTime * sin(3.5)))) *sin(iTime),1.0);
}