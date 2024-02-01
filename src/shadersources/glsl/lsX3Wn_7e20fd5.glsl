void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	const float fxFadeLength = 200.0;
	const float fxFadeStart = 80.0;
	const vec3 colBGIn = vec3(0.2,0.25,0.5);
	const vec3 colBGOut = vec3(0.5,0.1,0.1);
	const vec3 colSphereIn = vec3(0.001,0,0);
	const vec3 colSphereOut = vec3(0,0,0);
	const float edgeSmooth = 0.015;
	
	
	vec3 o;
	vec2 uv = fragCoord.xy / iResolution.xy;
	float aspect = iResolution.x / iResolution.y;
	
	//BG
	float vol = texture(iChannel0, vec2(0.1,0.1)).x;
	vec2 vec = uv - 0.5;
	vec.x *= aspect;
	float len = length(vec);
	vec3 colBG = mix(colBGIn, colBGOut, len * vol);
	vol *= vol * 2.0;
	o = colBG * vol;
	
	//SPHERES
	float prog = 0.3 * clamp((iTime - fxFadeStart) / fxFadeLength, 0.0, 1.0);
	
	for(float x = 0.1; x<1.0; x+=0.2)
	{
		for(float y = 0.05; y<1.0; y+=0.1)
		{
			vec2 pos = vec2(abs(y-0.5),abs(x-0.5));
			vec2 vol2 = texture(iChannel0, pos).xy;
			vol = vol2.x * vol2.y;
			vol *= vol;
			
			vec2 add = vec2(prog,0.0);
			float time = vol * 5.0 + x * y * iTime * prog;
			mat2 rot = mat2(cos(time),-sin(time),sin(time),cos(time));
			add *= rot;
			
			pos = add + vec2(x,y);
			vec2 vec = vec2(pos.x + ((pos.x-0.5)* vol * 0.05), pos.y);
			vec = uv - vec;
			vec.x *= aspect;
			float len = length(vec);
			
			//SPHERE
			float sphereRadius = 0.5 * vol-0.03;
			float a = 1.0 - smoothstep(sphereRadius, sphereRadius + edgeSmooth + prog * 0.2, len) - prog * 2.5;
			a = max(a,0.0);
			o += vec3(a, a * 0.3, a * 0.1);
			
			//SPHERE GLOW
			sphereRadius += 0.05;
			a = 1.0 - smoothstep(sphereRadius, sphereRadius + 0.1, len) - prog * 1.0;
			a = max(a,0.0);
			o += vec3(a, a * 0.3, a * 0.1) * 0.4 * vol;
		}
	}
	
	o.rg += vol * 0.5;
	o = (o-0.5) * 1.1 + 0.5;
	fragColor.rgb = o;
}