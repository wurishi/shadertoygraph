// by Nikos Papadopoulos, 4rknova / 2013
// WTFPL

// Sobel Kernel - Horizontal
// -1 -2 -1
//  0  0  0
//  1  2  1

// Sobel Kernel - Horizontal
// -1  0 -1
// -2  0 -2
// -1  0 -1

vec3 samplef(const int x, const int y, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy * iChannelResolution[0].xy;
	uv = (uv + vec2(x, y)) / iChannelResolution[0].xy;
	return texture(iChannel0, uv).xyz;
}

float luminance(vec3 c)
{
	return dot(c, vec3(.2126, .7152, .0722));
}

vec3 filterf(in vec2 fragCoord)
{
	vec3 hc =samplef(-1,-1, fragCoord) *  1. + samplef( 0,-1, fragCoord) *  2.
		 	+samplef( 1,-1, fragCoord) *  1. + samplef(-1, 1, fragCoord) * -1.
		 	+samplef( 0, 1, fragCoord) * -2. + samplef( 1, 1, fragCoord) * -1.;		

    vec3 vc =samplef(-1,-1, fragCoord) *  1. + samplef(-1, 0, fragCoord) *  2.
		 	+samplef(-1, 1, fragCoord) *  1. + samplef( 1,-1, fragCoord) * -1.
		 	+samplef( 1, 0, fragCoord) * -2. + samplef( 1, 1, fragCoord) * -1.;

	return samplef(0, 0, fragCoord) * pow(luminance(vc*vc + hc*hc), .6);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float u = fragCoord.x / iResolution.x;
    float m = iMouse.x / iResolution.x;
    
    float l = smoothstep(0., 1. / iResolution.y, abs(m - u));
    
    vec2 fc = fragCoord.xy;
    fc.y = iResolution.y - fragCoord.y;
    
    vec3 cf = filterf(fc);
    vec3 cl = samplef(0, 0, fc);
    vec3 cr = (u < m ? cl : cf) * l;
    
    fragColor = vec4(cr, 1);
}