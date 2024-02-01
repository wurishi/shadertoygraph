float lengthN(vec2 v, float n)
{
	vec2 l = pow(abs(v), vec2(n));
	
	return pow(abs(l.x-l.y), 3.0/n);
}

float rings(vec2 p)
{
	return sin(lengthN(mod(p*sin(iTime*0.15)*103.0, 2.0)-1.0, 4.0)*100.0*lengthN(p,20.0));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = (fragCoord.xy*2.0 -iResolution.xy) / iResolution.y;
	vec2 uv = fragCoord.xy / iResolution.xy;

	float c2 = rings(p);
	
	vec3 ty = texture(iChannel0,  c2+c2+c2+uv).xyz;
    
	
	vec3 obump = texture(iChannel0, uv).rgb;
	float displace = dot(ty, vec3(0.3, 0.6, 0.1));
	displace = (displace - 0.5)*sin(iTime*0.951)*0.03+0.01;
	
	

	vec4 face = texture(iChannel0, uv + vec2(displace));
	vec4 final = mix(face,vec4(ty,1.0),0.0);
	fragColor = final;
		
}