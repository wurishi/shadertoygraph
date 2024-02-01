float mask(vec2 p, vec2 c)
{
	float r = length((p - c)*vec2(2.5, 2.0));
	return smoothstep(0.6, 0.3, r);
}

float key(vec3 c)
{
	const vec3 green = vec3(0.15, 0.55, 0.1);
	float d = length(c - green);
	return smoothstep(0.2, 0.3, d);
}

vec2 rotate(vec2 p, float a)
{
	return p * mat2(cos(a), sin(a), -sin(a), cos(a));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 mouse = iMouse.xy / iResolution.xy;	
	
	vec2 centre = vec2(0.5, 0.6);
	if (iMouse.z > 0.0) {
		centre = mouse;
	}
	
	vec2 uv2 = uv;
	uv2 -= centre;	
	uv2 = rotate(uv2 - vec2(0.5), 0.2) + vec2(0.5);
	uv2 *= 1.8;
	uv2 += vec2(0.7, 0.48);	// face centre
	
	vec4 vid0 = texture(iChannel0, uv);
	vec4 vid1 = texture(iChannel1, uv2);
	float k = key(vid1.rgb);	
	float m = mask(uv, centre);
	
	// color correction
	vid1.rgb = vec3(dot(vid1.rgb, vec3(0.3, 0.59, 0.11)));	// b/w
	vid1.rgb *= vec3(1.0, 1.0, 0.9);	// yellowish
	vid1.rgb = vid1.rgb*0.8 + 0.2;		// brightness/contrast
	
	float t = smoothstep(18.0, 16.5, mod(iTime, 30.0));
		
	//fragColor = vid0;	
	//fragColor = vid1;
	//fragColor = (vid0 + vid1)*0.5;
	//fragColor = vec4(k);
	//fragColor = vec4(m);	
	//fragColor = vec4(k*m);
	//fragColor = mix(vid0, vid1, mouse.x);
	//fragColor = mix(vid0, vid1, mouse.x*m*k);
	//fragColor = mix(vid0, vid1, k*m);
	fragColor = mix(vid0, vid1, t*m*k);
}
