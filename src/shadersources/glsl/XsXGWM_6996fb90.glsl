void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = iTime;
	
	/*
	float ang = t;
	mat2 rotation = mat2(cos(ang), sin(ang),
			   			 -sin(ang), cos(ang));
	*/
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 texcoord = fragCoord.xy / vec2(iResolution.y);

	texcoord.y -= t*0.2;
	
	float zz = 1.0/(1.0-uv.y*1.7);
	texcoord.y -= zz * sign(zz);
	
	vec2 maa = texcoord.xy * vec2(zz, 1.0) - vec2(zz, 0.0) ;
	vec2 maa2 = (texcoord.xy * vec2(zz, 1.0) - vec2(zz, 0.0))*0.3 ;
	vec4 stone = texture(iChannel0, maa);
	vec4 blips = texture(iChannel1, maa);
	vec4 mixer = texture(iChannel1, maa2);
	
	float shade = abs(1.0/zz);
	
	vec3 outp = mix(shade*stone.rgb, mix(1.0, shade, abs(sin(t+maa.y-sin(maa.x))))*blips.rgb, min(1.0, pow(mixer.g*2.1, 2.0)));
	fragColor = vec4(outp,1.0);
}