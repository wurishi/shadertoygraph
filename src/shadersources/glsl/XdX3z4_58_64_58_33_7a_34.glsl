void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 diffuseTexture = texture(iChannel0, uv);
	vec4 modulateTexture = texture(iChannel1, uv);
	fragColor = diffuseTexture * modulateTexture;
}