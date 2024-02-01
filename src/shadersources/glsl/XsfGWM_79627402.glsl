void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = iTime;
	
	float quant = 45.0;
	float ang = floor((t*0.5)*quant)/quant;
	mat2 rotation = mat2(cos(ang), sin(ang),
			   			 -sin(ang), cos(ang));
	
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 coord = uv;
	vec4 samplev = texture(iChannel0, coord*(0.9 + sin(t*0.25)*0.1));
	vec3 dir = vec3((uv-vec2(0.5, 0.5))*1.5, -1.0);
	
	dir.xz = rotation*dir.xz;
	
	vec4 bg = texture(iChannel1, dir);
	
	float taint = 0.5;
	float bgmix = 0.0;
	
	if ((samplev.g - samplev.r*samplev.g) > 0.25) {
		bgmix = 1.0;
		//bgmix = pow(bgmix, 2.0);
		bgmix = min(1.0, bgmix);
	}
	
	vec3 color = mix(samplev.rgb, bg.rgb, bgmix);
	vec3 outp = vec3(0.4*dot(color, vec3(1.0, 1.0, 1.0)));
	
	
	fragColor = vec4(outp, 1.0);
}