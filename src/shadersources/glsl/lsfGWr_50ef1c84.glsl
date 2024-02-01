// recursive tetrahedra
// sgreen 8/2011
// based on:
// http://blog.hvidtfeldts.net/index.php/2011/08/distance-estimated-3d-fractals-iii-folding-space/

// transforms
vec3 rotateX(vec3 p, float a)
{
    float sa = sin(a);
    float ca = cos(a);
    vec3 r;
    r.x = p.x;
    r.y = ca*p.y - sa*p.z;
    r.z = sa*p.y + ca*p.z;
    return r;
}

vec3 rotateY(vec3 p, float a)
{
    float sa = sin(a);
    float ca = cos(a);
    vec3 r;
    r.x = ca*p.x + sa*p.z;
    r.y = p.y;
    r.z = -sa*p.x + ca*p.z;
    return r;
}

float tet(vec3 z)
{
     const int iterations = 10;
     const float scale = 2.0;

     vec3 a1 = vec3(1,1,1);
     vec3 a2 = vec3(-1,-1,1);
     vec3 a3 = vec3(1,-1,-1);
     vec3 a4 = vec3(-1,1,-1);
     vec3 c;
     float dist, d;
     int i = 0;
     for(int n=0; n < iterations; n++) {
          c = a1; dist = length(z-a1);
          d = length(z-a2); if (d < dist) { c = a2; dist=d; }
          d = length(z-a3); if (d < dist) { c = a3; dist=d; }
          d = length(z-a4); if (d < dist) { c = a4; dist=d; }
          z = scale*z-c*(scale-1.0);
          i++;
     }

     return (length(z)-2.0) * pow(scale, float(-i));
}

// optimized version using folds
float tet2(vec3 z)
{
    const int iterations = 11;
    const float scale = 2.0;

    int i = 0;
    for(int n = 0; n < iterations; n++) {
       if(z.x+z.y<0.0) z.xy = -z.yx; // fold 1
       if(z.x+z.z<0.0) z.xz = -z.zx; // fold 2
       if(z.y+z.z<0.0) z.yz = -z.zy; // fold 3
       z = z*scale - (scale-1.0);
       i++;
    }
    return length(z) * pow(scale, -float(i));
}

// distance to scene
float scene(vec3 p)
{
    p = mod(p + vec3(1.0), 2.0) - vec3(1.0);	// repeat
    return tet2(p);
}

// calculate scene normal
vec3 sceneNormal( vec3 pos )
{
    float eps = 0.001;
    vec3 n;
	float d = scene(pos);
    n.x = scene( vec3(pos.x+eps, pos.y, pos.z) ) - d;
    n.y = scene( vec3(pos.x, pos.y+eps, pos.z) ) - d;
    n.z = scene( vec3(pos.x, pos.y, pos.z+eps) ) - d;
    return normalize(n);
}

// ambient occlusion approximation
float ambientOcclusion(vec3 p, vec3 n)
{
    const int steps = 3;
    const float delta = 0.5;

    float a = 0.0;
    float weight = 1.0;
    for(int i=1; i<=steps; i++) {
        float d = (float(i) / float(steps)) * delta; 
        a += weight*(d - scene(p + n*d));
        weight *= 0.5;
    }
    return clamp(1.0 - a, 0.0, 1.0);
}

// lighting
vec3 shade(vec3 pos, vec3 n, vec3 eyePos)
{
    vec3 l = vec3(0.0, 1.0, 0.0);
    float diff = dot(n, l);
    diff = 0.5+0.5*diff;

    float ao = ambientOcclusion(pos, n);

    return vec3(diff*ao);
	//return vec3(diff);
}

// trace ray using sphere tracing
vec3 trace(vec3 ro, vec3 rd, out bool hit)
{
    const int maxSteps = 64;
    float hitThreshold = 0.001;
    hit = false;
    vec3 pos = ro;

	float td = 0.0;
    for(int i=0; i<maxSteps; i++)
    {
		if (!hit) {
			float d = scene(pos);
			d *= 0.5;
			if (abs(d) < hitThreshold) {
				hit = true;
				//break;
			}
			pos += d*rd;
			//td += d;
			//hitThreshold *= 1.05;
			//hitThreshold = td * 0.005;
		}
    }
    return pos;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 pixel = (fragCoord.xy / iResolution.xy)*2.0-1.0;

    // compute ray origin and direction
    float asp = iResolution.x / iResolution.y;
    vec3 rd = vec3(asp*pixel.x, pixel.y, -2.0);

    // fish-eye
    rd.z = -sqrt(2.0 - dot(rd.xy, rd.xy));
    rd = normalize(rd);

    // move camera
    //vec3 ro = vec3(0.0, 0.0, 1.5);
    vec3 ro = vec3(iTime*0.25, 0.3, iTime*0.25);
		
    float ay = iTime*0.17;
    float ax = sin(iTime*0.1)*0.25;
	
    rd = rotateY(rd, ay);
    rd = rotateX(rd, ax);

    // trace ray
    bool hit;
    vec3 pos = trace(ro, rd, hit);

	const vec3 fogColor = vec3(0.1, 0.3, 0.4);
    vec3 rgb = fogColor;
    if(hit)
    {
        // calc normal
        vec3 n = sceneNormal(pos);
        // shade
        rgb = shade(pos, n, ro);

        // fog
        float dist = length(pos - ro)*0.2;
        float fog = exp(-dist*dist);
		rgb = mix(fogColor, rgb, clamp(fog, 0.0, 1.0));
        //rgb *= fog;
    }

    fragColor=vec4(rgb, 1.0);
}
