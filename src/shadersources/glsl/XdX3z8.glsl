float pi = 3.241;

float sphere( in vec3 p, float s )
{
  return length(p)-s;
}

float box( vec3 p, vec3 b )
{
  vec3 d = abs(p) - b;
  return min(max(d.x,max(d.y,d.z)),0.0) +
         length(max(d,0.0));
}

vec3 twist(in vec3 p, float a, float b) {
	float c = cos(a*p.y);
    float s = sin(b*p.y);
    mat2  m2 = mat2(c,-s,s,c);
    return vec3(m2*p.xz,p.y);
}

vec3 repeat(in vec3 p, in float c) {
	vec3 vc = vec3(c);
	return mod(p,vc)-.5*vc;
}

float scene( in vec3 p, float m ) {
	
	// twist modifier
	float t1 = texture( iChannel0, vec2(.25,0.25) ).x * 4.;
	
	// twist parameters
	float tpa = -pi+.8*sin(t1)*pi;
	float tpb = -pi+.4*cos(t1)*pi;
	float a = box( twist(p,tpa,tpb), vec3(.15,.15,1.3) );
	float b = sphere(p, 0.3);
	return mix(a,b,clamp(t1/8.,0.,1.));
}

vec3 sceneNormal( in vec3 pos )
{
    float eps = 0.001;
    vec3 n;
	float d = scene(pos, 0.0);
    n.x = scene( vec3(pos.x+eps, pos.y, pos.z), 0.0 ) - d;
    n.y = scene( vec3(pos.x, pos.y+eps, pos.z), 0.0 ) - d;
    n.z = scene( vec3(pos.x, pos.y, pos.z+eps), 0.0 ) - d;
    return normalize(n);
}


vec3 march(in vec3 ro, in vec3 rd, out bool hit)
{
	float s = 0.1;
	for (int i = 0; i < 32; ++i) 
	{
		if (s < 0.1) {
			hit = true;
		}
		s = scene(ro, 0.0);
		ro+=rd*s;
		
	}

	return ro;
} 


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// compute pixel, with origin at the screen center
	vec2 uv = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;

	// compute ray origin and direction
    float asp = iResolution.x / iResolution.y;
    vec3 rd = normalize(vec3(asp*uv.x, uv.y, -2.0));
    vec3 ro = vec3(0, 0, 4);
	vec3 ls = normalize(vec3(1,0,1));	// light source
	vec3 eye = normalize(vec3(.5, .5, 1)); // eye

	bool hit = false;
	vec3 p = march(ro, rd, hit);
	if (hit) {
		// lighting
		vec3 n = sceneNormal(p);
		float diffuse = dot(n, ls) * .5;
		float spec = pow(dot(n, eye),200.0);
		float t = diffuse+spec;
		float c = clamp(texture( iChannel0, vec2(.25, .25 )).x, 0., 1.)*5.;
		fragColor = vec4(t*.5*c,t*.8*c,t*.4,1.0);
	}
}