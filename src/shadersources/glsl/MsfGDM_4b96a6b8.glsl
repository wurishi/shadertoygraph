void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec3 pr,pb,pa;	vec2 midUV, vr, vb, va;
	
	float dr, db, da;
	float radius = 0.1;
    
	float mdis = min(iResolution.x, iResolution.y);
	vec2 uv = fragCoord.xy / mdis;
	vec3 ch = texture(iChannel1, uv).xyz;		
	pr = vec3(0.0, 0.0, 2.0+ch.x);
	pb = vec3(0.0, 0.0, 1.0+ch.y);
	pa = vec3(0.0, 0.0, 1.0+ch.z);	
	pr.x += .9;
	pr.y += .5;
	pr.z += 0.2 * sin(1.12 * iTime);	
	pb.x += .9;
	pb.y += .5;
	pb.z += 0.2 * sin(1.62 * iTime);
	pa.x += 2.1 * sin(32.12 * iTime);;
	pa.y += .5;
	pa.z += 1.8 * sin(2.12 * iTime);	
	vr = pr.xy - uv;
	vb = pb.xy - uv;
	va = pa.xy - uv;	
	dr = length(vr);
	db = length(vb);
	da = length(va);	
	fragColor.z = 1.5 - smoothstep(db, 0.0, radius * pa.z) - 0.1;
	fragColor.x = 1.0 - smoothstep(dr, 0.0, radius * pr.z) - 0.1;
	fragColor.y = 1.0 - smoothstep(db, 0.0, radius * pb.z) - 0.1;
}