// aji's amazing scanline shader

const float linecount = 120.0;
const vec4 gradA = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 gradB = vec4(0.5, 0.7, 0.6, 1.0);
const vec4 gradC = vec4(1.0, 1.0, 1.0, 1.0);

vec2 pos, uv;

float noise(float factor)
{
	vec4 v = texture(iChannel1, uv + iTime * vec2(9.0, 7.0));
	return factor * v.x + (1.0 - factor);
}

vec4 base(void)
{
	return texture(iChannel0, uv + .1 * noise(1.0) * vec2(0.02, 0.0));
}

float triangle(float phase)
{
	//phase *= 2.0;
	//return 1.0 - abs(mod(phase, 2.0) - 1.0);
    // sin is not really a triangle.. but it's easier to do bandlimited
    float y = sin(phase * 3.14159);
    // if you want something brighter but more aliased, change 1.0 here to something like 0.3
    return pow(y * y, 1.0);
}

float scanline(float factor, float contrast)
{
	vec4 v = base();
	float lum = .2 * v.x + .5 * v.y + .3  * v.z;
	lum *= noise(0.3);
	float tri = triangle(pos.y * linecount);
	tri = pow(tri, contrast * (1.0 - lum) + .5);
	return tri * lum;
}

vec4 gradient(float i)
{
	i = clamp(i, 0.0, 1.0) * 2.0;
	if (i < 1.0) {
		return (1.0 - i) * gradA + i * gradB;
	} else {
		i -= 1.0;
		return (1.0 - i) * gradB + i * gradC;
	}
}

vec4 vignette(vec4 at)
{
	float dx = 1.3 * abs(pos.x - .5);
	float dy = 1.3 * abs(pos.y - .5);
    return at * (1.0 - dx * dx - dy * dy);
}

vec4 gamma(vec4 x, float f)
{
    return pow(x, vec4(1./f));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	pos = uv = (fragCoord.xy - vec2(0.0, 0.5)) / iResolution.xy;
	uv.y = floor(uv.y * linecount) / linecount;
	fragColor = gamma(vignette(gradient(scanline(0.8, 2.0))), 1.5);
}