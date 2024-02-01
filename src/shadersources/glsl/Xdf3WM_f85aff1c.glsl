#ifdef GL_ES
precision mediump float;
#endif

#define TMULT  0.012
#define tex    iChannel0
#define music  iChannel1
#define tmusic iChannelTime[1]


vec2 rot(vec2 p, float a) {
	return vec2(
		cos(a) * p.x - sin(a) * p.y,
		sin(a) * p.x + cos(a) * p.y);
}

float getbeat(void) {
	return (
		pow(texture(music, vec2( 0.01, 0.25 ) ).x, 4.0) +
		pow(texture(music, vec2( 0.30, 0.25 ) ).x, 8.0) + 
		pow(texture(music, vec2( 0.50, 0.25 ) ).x, 7.0) + 
		0.0
	);
}

vec3 gethi(vec3 p) {
	vec2  uv1    = p.xz * TMULT;
	vec3  col0   = texture(iChannel0, uv1).xyz;
	return col0;
}

vec3 map(vec3 p) {
	vec3  tk     = gethi(p);
	float k = 100.0;
	if(tmusic > 78.0) {
		k      = 3.0 - dot(abs(p), vec3(0, 1, 0)) - tk.z * getbeat() * 4.0;
	} else {
		k      = 3.0 + dot(p, vec3(0, 1, 0)) - tk.z * getbeat() * 4.0;
	}
	return vec3(tk.xy, k);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2   uv = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
	
	//ray
	vec3  dir = normalize(vec3(uv * vec2(iResolution.x / iResolution.y, 1.0), 1.0));
	dir.xz    = rot(dir.xz, tmusic * 0.1);
	dir.xy    = rot(dir.xy, sin(tmusic * 0.02) * 0.3);
	//dir.yz    = rot(dir.yz, -0.4 + sin(1.3 * sin(tmusic * 0.04) * 0.3));
	
	//cam pos
	vec3  pos = vec3(0,0,0);
	pos.x    += sin(tmusic * 0.1) * 4.0;
	pos.z    += tmusic * 5.0;
	vec3  col = vec3(0);
	vec3   mi = vec3(0);
	float   t = 0.01;
	
	//raymarching
	for(int i = 0 ; i < 128; i++) {
		mi    = map(pos + dir * t * 0.3);
		if(mi.z < 0.01) break;
		t    += mi.z;
	}
	vec3   IP = pos + dir * t;
	
	//light.
	vec3    L = normalize(vec3(0.6, 0.4, 1.5));
	
	//col
	vec3 ycol = max(texture(tex, mi.xy).xyz, 0.0) + map(0.3 * L + IP).z * 0.01;
	ycol      = mix(ycol, ycol.zyx, cos(tmusic * (1.0 / 36.0)) * 5.0);
	
	//fake sun
	vec3 sun  = vec3(5, 2, 1) * max(dot(L, dir), 0.1);
	sun       = sun + vec3(1, 2, 3) * 0.5;
	sun      *= sun;

	//fog
	vec3  fog = mix(vec3(4, 2, 1), vec3(3, 2, 1) * 0.1, t * 0.01) * 0.2;

	//cielo
	if(t > 256.0) {
		fog   = vec3(0);
		ycol  = sun * pow(getbeat(), 2.0);
	}
	
	//color
	col       = ycol;
	fragColor = vec4(sqrt(col * 0.25) + fog, 1.0);
}
