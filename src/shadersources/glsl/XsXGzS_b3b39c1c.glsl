float rand( vec2 n ) {
    return fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453);
}
float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}
vec2 fbm(float x, float y,vec4 m)
{
	float totM = m.r*m.g*m.b*m.a;
	vec2 total =vec2(0,0);
	float frequency = 0.001/(totM*y); //grid pÃ¥slutten
	float amplitude = 10.*totM;
	const int octaves = 10;
	float gain = 10.04;
	float lacunarity = 0.0001*totM;
	for (int i = 0; i < octaves; i++)
	{
		vec2 kk = vec2(x * frequency, y * frequency);
		total += noise(kk) * amplitude;         
		frequency *= lacunarity;
		amplitude *= gain;
	}                       
	vec2 map = total;
	return map;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 xuv = uv;
	vec4 mzk = texture(iChannel0,uv);
	uv = fbm( uv.x  , uv.y , mzk);

	vec4 tex = texture(iChannel1,uv);

	fragColor = tex;
}

