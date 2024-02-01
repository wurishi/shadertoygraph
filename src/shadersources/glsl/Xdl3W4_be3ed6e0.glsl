uniform sampler2D sampler0;
uniform sampler2D sampler1;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 tex = texture(sampler0, uv) ;
	tex.xy = vec2(tex.x+0.5+sin(fragCoord.x*sqrt(fragCoord.y)),tex.y-0.5+cos(fragCoord.y*sqrt(fragCoord.x)));
	vec4 output1 = tex;
	fragColor = 	output1;

		//
}