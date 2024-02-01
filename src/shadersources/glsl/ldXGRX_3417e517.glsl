// srtuss, 2013

#define PI 3.14159265358979323

vec2 rotate(vec2 p, float a)
{
	return vec2(p.x * cos(a) - p.y * sin(a), p.x * sin(a) + p.y * cos(a));
}

float fft(float band)
{
    return texture( iChannel1, vec2(band,0.0) ).x;
}

// iq's fast 3d noise tortured
float noise3(in vec3 x)
{
    vec3 p = floor(x);
    vec3 f = fract(x);
	f = f * f * (3.0 - 2.0 * f);
	vec2 uv = (p.xy + vec2(37.0, 17.0+smoothstep(0.8,0.99, fft(0.))) * p.z) + f.xy;
	vec2 rg = texture(iChannel0, (uv + 0.5) / 256.0, -100.0).yx;
	rg += texture(iChannel0, (uv + iTime) / 64.0, -100.0).yx/10.0;
	rg += texture(iChannel0, (uv + iTime/3.2 + 0.5) / 100.0, -100.0).zx/5.0;
	return mix(rg.x, rg.y, f.z);
}

// 3d fbm
float fbm3(vec3 p)
{
	return noise3(p) * 0.5 + noise3(p * 2.02) * 0.25 + noise3(p * 4.01) * 0.125;
}

// animated 3d fbm
float fbm3a(vec3 p)
{
	vec2 t = vec2(iTime * 0.4, 0.0);
	return noise3(p + t.xyy) * 0.5 + noise3(p * 2.02 - t.xyy) * 0.25 + noise3(p * 4.01 + t.yxy) * 0.125;
}

// more animated 3d fbm
float fbm3a_(vec3 p)
{
	vec2 t = vec2(iTime * 0.4, 0.0);
	return noise3(p + t.xyy) * 0.5 + noise3(p * 2.02 - t.xyy) * 0.25 + noise3(p * 4.01 + t.yxy) * 0.125 + noise3(p * 8.03 + t.yxy) * 0.0625;
}

// background
vec3 sky(vec3 p)
{
	vec3 col;
	float v = 1.0 - abs(fbm3a(p * 4.0) * 2.0 - 1.0);
	float n = fbm3a_(p * 7.0 - 104.042);
	v = mix(v, pow(n, 0.3), 0.5);
	
	col = vec3(pow(vec3(v), vec3(14.0, 9.0, 7.0))) * 0.8;
    col += vec3(smoothstep(0.75,0.99,fbm3a_(p*6.))*8., 0.0, 0.0)*fft(32.);
	return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = uv * 2.0 - 1.0;
	uv.x *= iResolution.x / iResolution.y;
	
	float t = iTime;
	
	vec3 dir = normalize(vec3(uv, 1.1));
	
	dir.yz = rotate(dir.yz, sin(t/15.+smoothstep(0.99,0.999, fft(0.))));
	dir.xz = rotate(dir.xz, cos(t/13.));
	dir.xy = rotate(dir.xy, cos(t/12.+smoothstep(0.5,0.999, fft(213.))));
	
	vec3 col = sky(dir);

	// dramatize colors
	col = pow(col, vec3(1.5)) * 2.0;

	fragColor = vec4(col, 1.0);
}