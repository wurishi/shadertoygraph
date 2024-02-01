void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// inner and outter rectangles
	vec4 rectOuter = vec4(25.0, 25.0, iResolution.x - 25.0, iResolution.y - 25.0);
	vec4 rectInner = vec4(100.0, 100.0, iResolution.x - 100.0, iResolution.y - 100.0);
	rectOuter /= iResolution.xyxy;
	rectInner /= iResolution.xyxy;
	// distances between inner and outter
	vec4 rectDist = rectInner - rectOuter;
	// bg and content uv calculation
	vec4 uv = fragCoord.xyxy / iResolution.xyxy;
	// content uv offset
	uv.zw += vec2(0.25 * iTime);
	uv.zw = mod(uv.zw, vec2(1.0));
	
	vec4 maskOuter = vec4(0.0);
	maskOuter.xy = rectOuter.xy - uv.xy;
	maskOuter.zw = uv.xy - rectOuter.zw;
	vec4 maskInner = vec4(0.0);
	maskInner.xy = rectInner.xy - uv.xy;
	maskInner.zw = uv.xy - rectInner.zw;
	maskInner /= rectDist;
	float mask = 1.0;
	mask -= ceil(maskOuter.x);
	mask -= ceil(maskOuter.y);
	mask -= ceil(maskOuter.z);
	mask -= ceil(maskOuter.w);
	mask = min(mask, 1.0 - maskInner.x);
	mask = min(mask, 1.0 - maskInner.y);
	mask = min(mask, 1.0 + maskInner.z);
	mask = min(mask, 1.0 + maskInner.w);
	mask = clamp(mask, 0.0, 1.0);
	vec4 bg = texture(iChannel0, uv.xy);
	vec4 cont = texture(iChannel1, uv.zw);
	fragColor = mix(bg, cont, cont.w * mask);
}