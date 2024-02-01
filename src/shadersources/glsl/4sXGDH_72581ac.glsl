// created by movAX13h, May 2013

#define I_HAVE_NO_WEB_AUDIO 0

struct Frame
{
	float s1,s2,s3,s4,s5; // slices
};

Frame frame(Frame frames[8], int id) 
{
    return frames[id];
}
	
float slice(Frame frame, int id)
{
	if (id == 0) return frame.s1;
	if (id == 1) return frame.s2;
	if (id == 2) return frame.s3;
	if (id == 3) return frame.s4;
	return frame.s5;
}

int sprite(Frame frame, vec2 p)
{
	int d = 0;
	p = floor(p);
	if (clamp(p.x,0.0,5.0) == p.x && clamp(p.y,0.0,9.0) == p.y)
	{
        int s = int(p.y / 2.0);
        float o = float(s)*12.0;
        float k = ((p.x + p.y*6.0) - o)*2.0;
        float n = slice(frame, s);
        if (int(mod(n/(pow(2.0,k)),2.0)) == 1) d += 2;
        if (int(mod(n/(pow(2.0,k+1.0)),2.0)) == 1) d++;
	}
	return d;
}

float invader(vec2 p, float n, float d)
{
	p.x = abs(p.x);
	p.y = -floor(p.y - 5.0);
	if (p.x <= 2.0) 
	{
		if (int(mod(n/(pow(2.0,floor(p.x + p.y*3.0))),2.0)) == 1) return 1.0;
	}
	return d;
}

float hash(float n)
{
    return fract(sin(n)*43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// frames
	Frame frames[8];
	frames[0].s1=2228224.0; frames[0].s2= 721568.0; frames[0].s3=3997948.0; frames[0].s4=16073552.0; frames[0].s5=15790420.0;
	frames[1].s1= 655360.0; frames[1].s2=3130040.0; frames[1].s3= 852176.0; frames[1].s4=  328528.0; frames[1].s5=12832084.0;
	frames[2].s1=2785280.0; frames[2].s2=1032880.0; frames[2].s3= 852176.0; frames[2].s4=  327888.0; frames[2].s5=  983888.0;
	frames[3].s1=2752648.0; frames[3].s2=1032880.0; frames[3].s3= 458960.0; frames[3].s4=  340083.0; frames[3].s5= 3932492.0;
	frames[4].s1=2228224.0; frames[4].s2= 721568.0; frames[4].s3= 459004.0; frames[4].s4=  376944.0; frames[4].s5=15790420.0;
	frames[5].s1= 655360.0; frames[5].s2=3130040.0; frames[5].s3= 852176.0; frames[5].s4=  327792.0; frames[5].s5=12832084.0;
	frames[6].s1=2785280.0; frames[6].s2=3130032.0; frames[6].s3= 458960.0; frames[6].s4=  327888.0; frames[6].s5=  983888.0;
	frames[7].s1=2752648.0; frames[7].s2=1032880.0; frames[7].s3=3473616.0; frames[7].s4=  340819.0; frames[7].s5= 3932492.0;
	
	// time & space
  #if I_HAVE_NO_WEB_AUDIO
	float time = iTime*1.89;
  #else
	float time = iChannelTime[1]*1.89-0.08;
  #endif
	
	float mouse = iMouse.x;
	if (mouse < 10.0 || mouse > iResolution.x-10.0) mouse = iResolution.x*0.68;
	
	vec2 p = fragCoord.xy * 0.25;
	p.y = - p.y;

	vec3 col = vec3(0.0, 0.0, 0.1);
	vec3 colors[4];
	
	// ground
	colors[0] = vec3(0.38, 0.0, 0.06); colors[1] = vec3(0.57, 0.14, 0.07); colors[2] = vec3(0.79, 0.33, 0.08); colors[3] = vec3(0.9, 0.51, 0.13);
	
	float f = floor(-iResolution.y*0.125 + 11.0);
	int i = int(4.0*texture(iChannel0, floor(p)*0.005 + vec2(0.2,0.5)).r);
	col = mix(col, colors[i], step(f, p.y));

	// swirl
	float h = smoothstep(2.0, 60.0, abs(fragCoord.x-mouse));
	vec2 q = p;
	q.x += floor((1.0-h)*(5.0*sin(0.1*p.y + time) + 3.0*sin(0.07*p.y + time + 2.0)));
	
    // background
	i = int(4.0*texture(iChannel0, floor(q)*0.003).r);
	h = 1.2*smoothstep(f, f*4.0, q.y+sin(time + q.x*0.3)*5.0);
	col = mix(col, colors[i], h);
	
	// grass
	colors[0] = vec3(0.44, 0.57, 0.0); colors[1] = vec3(0.13, 0.39, 0.13);
	
	vec2 g = floor(p);
	float d = f - g.y;
	h = floor(hash(g.x)*2.3);
	g.y += h;
	i = int(abs(sin(-h*0.2+d*0.6+0.3))*2.0);
	col = mix(col, colors[i], 1.0 - step(3.0, abs(g.y-f-2.0)));

	// lemmings
	colors[0] = vec3(0.0); colors[1] = vec3(0.0, 0.73, 0.0); colors[2] = vec3(0.26, 0.26, 0.92); colors[3] = vec3(1.0, 1.0, 1.0);
	p.y += 9.0-f;
	if (iMouse.z > 0.0) p.x *= 1.0 - 2.0 * step(fragCoord.x, mouse);
	else p.x *= 1.0 - 2.0 * step(mouse, fragCoord.x);
	p.x = mod(p.x + floor(time*4.0), 12.0);
	
	f = length(fragCoord.xy-vec2(mouse, max(iResolution.y *0.5 - 30.0, fragCoord.y)));
	p.y += floor(60.0*(smoothstep(40.0, 0.0, floor(f)))); // elevation
	i = sprite(frame(frames, int(mod(floor(time*4.0+1.0), 8.0))), p);
	h = smoothstep(10.0, 120.0, abs(fragCoord.x-mouse));
	col = mix(col, colors[i], h*min(1.0, float(i)));

	// beam
	float r = 10.0*sin(p.y*0.1 + time*2.0);
	h = smoothstep(180.0, 10.0, f-r);
	col += h*0.6;

	#if 0
	h *= smoothstep(120.0, 10.0, r); col *= h;
	#endif

	// invaders
	p = 0.25*(fragCoord.xy - vec2(mouse, iResolution.y));
	p.x += sin(p.y*0.15 - time*3.0)*2.0;
	p.y += time*(1.0 - 2.0 * step(0.1, iMouse.z))*15.0;

	q.x = p.x;
	q.y = mod(p.y, 20.0);
	
	float t = floor(time * 0.5);
	h = mod(hash(floor(p.y/20.0)),33554430.0);
	f = invader(floor(q), h, 0.0) * smoothstep(iResolution.y*0.6, iResolution.y, fragCoord.y);
	col = mix(col, vec3(1.0), f);
	
	fragColor = vec4(col, 1.0);
}