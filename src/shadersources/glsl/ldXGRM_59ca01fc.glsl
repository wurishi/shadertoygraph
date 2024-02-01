float rand(vec2 co){
    return 0.5+0.5*fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 t(vec2 uv)
{
	float j = sin(uv.y*2.0*3.14+uv.x*2.0+iTime*2.0);
	float i = sin(uv.x*10.0-uv.y*2.0*3.14+iTime*3.0);
	
	float p = clamp(i,0.0,0.2)-clamp(j,0.0,0.2);
	float n = -clamp(i,-0.2,0.0)+0.2*clamp(j,-0.2,0.0);
	
	return 5.0*(vec4(1.0,0.25,0.125,1.0)*n + vec4(1.0,1.0,1.0,1.0)*p);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float d = 0.01;
	vec2 uv = fragCoord.xy / iResolution.xy - 0.5;
	vec3 p = vec3(sin(iTime*1.2),cos(iTime),sin(iTime));
	
	float l = 2.0 - pow(distance(p,vec3(uv,0.0)),2.0);
	
	
	fragColor = t(uv+l)+l;
}