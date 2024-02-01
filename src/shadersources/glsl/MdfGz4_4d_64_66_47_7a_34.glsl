void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float fs = iChannelTime[0] * .03;
	vec2 vu = vec2(fs);
	vec2 v = vec2(cos(fs));
	uv.x += (sin(iChannelTime[0]+fragCoord.y*.1)* .01)*pow(texture(iChannel1, v).r,6.0);
	
	// Green
	vec4 green = vec4(0.01, 0.6, 0.03, 1.0);

	// Vignette with flicker
	float distToCentre = (0.8+texture(iChannel1, uv).r*.03)-length(uv-vec2(.5));

	vec2 uv1 = vec2(float(int(uv*200.))*.005,float(int(uv.y*100.))*.01  );
	
	vec4 samplev = texture(iChannel0, uv1) * green + vec4(.2);
	samplev += distToCentre*.6-pow(texture(iChannel1, vu).r,4.0)*.08;

	samplev += texture(iChannel1, vec2(uv.x*.001, uv.y*.6+(.3+sin(iTime*.1)*2.5)))*.1;
	samplev += texture(iChannel1, vec2(uv.x*.001, uv.y*.6+(.3+sin(iTime*.13)*1.5)))*.03;
	
	fragColor = vec4(samplev*.8);
}