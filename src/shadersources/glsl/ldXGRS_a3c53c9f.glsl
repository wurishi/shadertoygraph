// Zhirnokleev Konstanin 2013
// Creative Commons Attribution-ShareAlike 3.0 Unported
//
// Bits of code taken from Inigo Quilez, including hash(), noice(), softshadow()

float freqs[4];
float sinTime;
float hash( float n )
{
    return fract(sin(n)*43758.5453123);
}

float noise( in vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);

    f = f*f*(3.0-2.0*f);

    float n = p.x + p.y*57.0 + 113.0*p.z;

    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}

float Dist(in vec3 p, out vec3 color){
	 
	float c = cos(0.5 * sinTime * p.y);
    float s = sin(0.5 * sinTime * p.y);
    mat2  m = mat2(c, -s, s, c);
   
	vec3  RayPos = vec3(m*p.xz, p.y).xzy;
	vec3  d = abs(RayPos) - vec3(2.0, 5.0, 2.0);
  
	color = vec3(0.0, 1.0, 0.0);	
	float distance = min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0)) + noise(RayPos * 0.2 + vec3(iTime)) * (freqs[3] * 3.0);
	
	
	float dist = length(p - vec3(6.0,sinTime*2.0, 0.0)) - 2.0;
	if (distance > dist) 
	{
		distance = dist;
		color = vec3(1.0, 0.0, 0.0);
	}
	
	
	return distance;
	
}

float softshadow( in vec3 ro, in vec3 rd, float mint, float k )
{
    float res = 1.0;
    float t = mint;
    for( int i=0; i<25; i++ )
    {
		vec3 C;
        float h = Dist(ro + rd*t, C);
        res = min( res, k*h/t );
        t += h;//clamp( h, 0.001, 0.6 );
    }
    return clamp(res,0.0,1.0);
}

vec3 trace(vec3 start, vec3 dir){
 	vec3 Color = vec3(0.0, 0.0, 0.0);
    vec3 RayPos = start;
    float step = 0.6;
	float dist = 0.0;
	vec3 Normal;
	float coff = 1.0;
	float find;
	
	for(int k=0; k<2; k++){
		
		find = 0.0;
		for(int i=0; i<35; i++)
		{
			vec3 color;
			step = Dist(RayPos, color);
			dist += step;
			RayPos = start + dist * dir;
			
			if( abs(step) <= 0.005){
				const float eps = 0.005;
				vec3 C;
				Normal = normalize(vec3(Dist(RayPos+vec3(eps,0,0),C)-Dist(RayPos+vec3(-eps,0,0),C),
									    Dist(RayPos+vec3(0,eps,0),C)-Dist(RayPos+vec3(0,-eps,0),C),
									    Dist(RayPos+vec3(0,0,eps),C)-Dist(RayPos+vec3(0,0,-eps),C)));
				float shadow = (0.3+ softshadow(RayPos + Normal * 0.03, normalize(vec3(0.4, 0.6, 0.0)), 0.01, 20.0) * 0.7);
				Color = mix(Color, color * vec3(dot(Normal, -dir)) * shadow, coff) ;
				Color = mix(Color, vec3(0.0), dist/20.0);
				find = 1.0;
				break;
			}
		}
		
		
			float alpha = dot(dir, vec3(0.0, 1.0, 0.0));
			if (find == 0.0)
			{
				if (alpha < 0.0)
				{
					alpha = -(5.0 +dot(vec3(0.0, 1.0, 0.0), start))/alpha; 
					Normal = vec3(0.0, 1.0, 0.0);
					RayPos = start + dir * alpha;
					
					float shadow = (0.3+ softshadow(RayPos + Normal * 0.03, normalize(vec3(0.4, 0.6, 0.0)), 0.01, 20.0) * 0.7);
					Color = mix(Color, vec3(shadow) * dot(Normal, -dir), coff);
				} else {
					Color = mix(Color, alpha * vec3(0.3, 0.0, 0.2) * freqs[0], coff);	
				}
			}
			
		//RayPos -= step;
		//step = -0.6;
		dist = 0.0;
		start = RayPos + Normal * 0.01;
		RayPos = start;
		//step = 0.01;
		dir = reflect(dir, Normal);
		coff *= 0.3;
	}
	
   	
	return Color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	sinTime = sin(iTime);
	freqs[0] = texture( iChannel0, vec2( 0.01, 0.5 ) ).x;
	freqs[1] = texture( iChannel0, vec2( 0.07, 0.5 ) ).x;
	freqs[2] = texture( iChannel0, vec2( 0.15, 0.5 ) ).x;
	freqs[3] = texture( iChannel0, vec2( 0, 0.25 ) ).x;
	
    vec3 CamPos = vec3(cos(iTime), sinTime * 0.2 , sinTime) * 10.0;
    vec3 CamDir = normalize(-CamPos);
    vec3 CamRight = normalize(cross(CamDir, vec3(0.0, 1.0, 0.0)));
    vec3 CamUp = normalize(cross(CamRight, CamDir));
   
    vec2 uv = 2.0 * fragCoord.xy / iResolution.xy - 1.0;
    float aspect = iResolution.x / iResolution.y;
    vec3 Dir = normalize(vec3(uv * vec2(aspect, 1.0), 1.0 + sinTime * 0.7 )) * mat3(CamRight,CamUp,CamDir);
   

    fragColor = vec4(trace(CamPos, Dir),1.0);
}