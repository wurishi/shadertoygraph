// With tweaks by PauloFalcao
// and khaaan

float map( vec3 p ){
    p.x+=sin(p.z*4.0+iTime*4.0)*0.1*cos(iTime*0.1);
    p = mod(p,vec3(1.0, 1.0, 1.0))-0.5;
    return length(p.xy)-.1;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 pos = (fragCoord.xy*2.0 - iResolution.xy) / iResolution.y;
    vec3 camPos = vec3(cos(iTime*0.3), sin(iTime*0.3), 1.5);
    vec3 camTarget = vec3(0.0, 0.0, 0.0);

    vec3 camDir = normalize(camTarget-camPos);
    vec3 camUp  = normalize(vec3(0.0, 1.0, 0.0));
    vec3 camSide = cross(camDir, camUp);
    float focus = 0.0-8.0*iMouse.y/iResolution.y+sin(iTime*0.75)*0.5;

    vec3 rayDir = normalize(camSide*pos.x + camUp*pos.y + camDir*focus);
    vec3 ray = camPos;
    float d = 0.0, total_d = 0.0;
    const int MAX_MARCH = 10;
    const float MAX_DISTANCE = 5.0;
    float c = 1.0;
    for(int i=0; i<MAX_MARCH; ++i) {
        d = map(ray);
        total_d += d;
        ray += rayDir * d;
        if(abs(d)<0.001) { break; }
        if(total_d>MAX_DISTANCE) { c = 0.; total_d=MAX_DISTANCE; break; }
    }
	
    float fog = 5.0;
    vec4 result = vec4( vec3(c*.4 , c*.6, total_d+c) * (fog - total_d) / fog, 1.0 );

    ray.z -= 5.+iTime*.5;
    float r = 7.0;
    fragColor = clamp(result*(step(r,.3)+r*.2+.1), 0.0, 1.0);
    fragColor.a = (fog - total_d) / fog;
}
