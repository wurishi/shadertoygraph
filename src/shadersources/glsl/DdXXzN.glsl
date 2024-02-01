// fork of Hatchling's excellent http://shadertoy.com/view/ddS3WR
// swapped distance field extrapolation and ray marcher
// Golfed from 11934 ch down to 4611 so far.
// With some more effort I could probably improve the noise
// and fine tune the shape of the mountains more.
// But I'm pretty happy with it at this point.

#define quat vec4

quat FromAngleAxis(vec3 angleAxis)
{
    float mag = length(angleAxis),
       halfAngle = mag * .5,
       scalar = sin(halfAngle) / max(mag, .00001);
    return vec4(angleAxis * scalar, cos(halfAngle));
}

vec3 qmul(quat q, vec3 v)
{
    vec3 t = 2. * cross(q.xyz, v);
    return v + vec3(q.w * t) + cross(q.xyz, t);
}

quat qmul(quat a, quat b)
{
    quat q;
    q = vec4(
        a.wwww * b 
      + (a.xyzx * b.wwwx + a.yzxy * b.zxyy) * vec4(1, 1, 1,-1) 
      - a.zxyz * b.yzxz
        );
    return q;
}

#define CH iChannel0
#define CHR iChannelResolution[0]

float maxHeight()
{
    return .3; //200. / CHR.x;        
}

float precis()
{
    return 1.5 / CHR.x;        
}

float terrain(vec2 p)
{
    p.x /= CHR.x / CHR.y;    
    p += .5;        
    if (clamp(p, 0., 1.) != p) return .5;    
    vec4 t = texture(CH, p);
    return t.r * maxHeight();
}

vec3 terrainGrad(vec3 p, out vec2 curv)
{    
    float prec = precis();
    float hC = terrain(p.xz);    
    vec3 pC = vec3(p.x, hC, p.z),
      pR = p + vec3(prec, 0,  0),
      pL = p - vec3(prec, 0,  0),
      pT = p + vec3( 0, 0, prec),
      pB = p - vec3( 0, 0, prec);    
    pR.y = terrain(pR.xz);
    pL.y = terrain(pL.xz);
    pT.y = terrain(pT.xz);
    pB.y = terrain(pB.xz);    
    vec3 n = normalize(cross(pT - pB, pR - pL));    
    float cx = dot(pC + pC - pR - pL, n),
          cy = dot(pC + pC - pT - pB, n);
    curv = vec2(cx, cy) / prec;
    return n;
}

// recombined
vec3 skybox(vec3 dir, bool blurry)
{
    float g = dir.y * .5 + .5;
    if (!blurry) {
        g *= g;
        g *= g;
    }
    g = 1.-g;
    g *= g * g;
    if (!blurry) {
        g *= g;
        g *= g;
    }
    g = 1.-g;
    if (!blurry) {
        g = smoothstep(0., 1., g);
        g = smoothstep(0., 1., g);
        g = smoothstep(0., 1., g);
        g = smoothstep(0., 1., g);
    }    
    vec3 h = pow(vec3(g), vec3(8, 1, 1));
    h = vec3(1.)-h;
    h = pow(h, vec3(.4, .5, 4));
    h = vec3(1.)-h;    
    return mix(vec3(.99,.99,.99), vec3(.01,.02,.2), h) * 2.;
}

vec3 render(vec3 camPos, vec3 camDir)
{
    vec3 sky = skybox(camDir, false); // we'll need it regardless
    if (camPos.y >= 0. && camDir.y >= 0.) 
        return sky; // early out

    const float range = .7;
    vec3 p = camPos, near = p, far = p + camDir * range;
    float maxD = 1.;
    bool hit = false;
    // prone to undermarching b/c distance scaling is so wack, plus it's noisy
    // perhaps should run another eikonal smoothing pass to compute actual SDF
    // or simply use the gamma trick for mip maximum
    float t = 0.;
    for (int iter = 384; --iter > 0 && t < range; ) {
        p = t * camDir + camPos;
        float h = (p.y - terrain(p.xz)) / maxHeight() / 18.;
        if (abs(h) < .002 * t) {
            hit = true; 
            break;
        }
        t += .7 * h; // / range;
    }
    if (!hit) return sky;
    maxD = t/range;
    
    vec2 curve2;
    vec3 normal = terrainGrad(p, curve2);
    
    vec2 posCurve2 =  max(vec2(0), curve2);
    vec2 negCurve2 = -min(vec2(0), curve2);
    
    float posCurve = posCurve2.x + posCurve2.y;
    posCurve = posCurve / (.2 + posCurve);
    float negCurve = negCurve2.x + negCurve2.y;
    negCurve = negCurve / (.2 + negCurve);
    float curve = (curve2.x + curve2.y);
    curve = curve / (.2 + abs(curve));
    
    p = vec3(p.x, terrain(p.xz), p.z);

    vec3 albedo  = vec3(1);
    
    float slopeFactor;
    float heightFactor;
    {
        heightFactor = p.y / maxHeight();
        
        heightFactor = smoothstep(0., 1., heightFactor);        
        heightFactor = smoothstep(0., 1., heightFactor);
        
        slopeFactor = abs(normal.y);
        slopeFactor *= slopeFactor;
        slopeFactor *= slopeFactor;
        slopeFactor *= slopeFactor;
        //slopeFactor *= slopeFactor;
        slopeFactor = 1.-slopeFactor;
        slopeFactor *= slopeFactor;
        slopeFactor *= slopeFactor;
        //slopeFactor *= slopeFactor;
        slopeFactor = 1.-slopeFactor;
        //slopeFactor = smoothstep(0., 1., slopeFactor);
        //slopeFactor = smoothstep(0., 1., slopeFactor);
        //slopeFactor = smoothstep(0., 1., slopeFactor);
        
        const vec3
            flatLow = vec3(.1, .4, .1),
            flatHigh = vec3(.7, .7, .5),        
            slopeLow = vec3(.4, .7, .2),
            slopeHigh = vec3(.3, .2, .1);
        
        vec3 flatColor = mix(flatLow, flatHigh, heightFactor);
        vec3 slopeColor = mix(slopeLow, slopeHigh, heightFactor);
        
        albedo = mix(slopeColor, flatColor, slopeFactor);
    }
    
    albedo = mix(albedo, (albedo+vec3(.7))*vec3(.7,.6,.3), posCurve); 
    
    float rivers;
    {
        rivers = max(0.,negCurve - posCurve);
        
        rivers = pow(rivers, pow(2., mix(.5, -.7, slopeFactor) + mix(-.7, .7, heightFactor)));   

        rivers = smoothstep(0., 1., rivers);
        rivers = smoothstep(0., 1., rivers);
        
        albedo = mix(albedo, vec3(.1,.2,.5), rivers); 
    }
    float snow = pow(heightFactor, 8.);
    albedo = min(mix(albedo, vec3(8), snow), 1.);

    albedo *= albedo; // guess all those colors were specified in sRGB gamma?

    const vec3 lightDir = normalize(vec3(0, 3, 5)),
      lightColor = 2. * vec3(1., .75, .5);    
    float nl = max(0., dot(normal, lightDir));
    
    float specm = 0.;
    specm = mix(specm, .5, posCurve);
    specm = mix(specm, 3., rivers);
    specm = mix(specm, 2., snow);

    float spec = max(0., dot(camDir, reflect(lightDir, normal))); // phong specular
    spec = pow(spec, 128.);

    float ambient = normal.y * .5 + .5; // hemisphere ambient
    ambient *= .2*exp2(-4. * negCurve);
    vec3 ambientColor = ambient * skybox(normal, true);

    vec3 color = nl*lightColor*(albedo + spec*specm) + ambientColor * albedo;

    float d2 = t*t; //dot(p - camPos, p - camPos);  
    color = mix(sky, color, exp2(-3.*d2)); // fog  
    return color;
}

void mainImage(out vec4 fragColor, vec2 fragCoord)
{
    vec3 d = normalize(vec3(fragCoord - .5*iResolution.xy, iResolution.y)), // ray dir
       e = vec3(0, maxHeight() * 1., -.5); // eye pos    
    quat pan = FromAngleAxis(vec3(0, iTime * .1, 0)),
       tilt = normalize(quat(1,0,0,4));
    e = qmul(pan, e);
    d = qmul(qmul(pan, tilt), d);    
    vec3 c = render(e, d);
    fragColor = vec4(c / (c + .3), 1);
}  
    // just show the heightmap
    //fragColor = textureLod(iChannel0, fragCoord/iResolution.xy, 0.);
    //fragColor /= fragColor.a;
