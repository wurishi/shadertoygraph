float smoothNoise(vec2 uv, sampler2D iChannel)
{  
	return texture( iChannel, 2.0*uv ).x;
}

float turbulence(vec2 uv, float size, sampler2D iChannel)
{
    float value = 0.0, initialSize = size;
    
	for(size = initialSize; size >= 1.0; size /= 2.0) {
        value += smoothNoise(vec2(uv.x / size, uv.y / size), iChannel) * size;
    }
    
    return (0.5 * value / initialSize);
}

float getSpiral(vec2 uv, float t) {
	uv = uv * 2.0 - vec2(1.0, 1.0); // -1 .. +1
	float d = length(uv); // distance from center
	float thickness = 15.0 + cos(t * 0.10) * 3.0 + sin(d) * 3.0;
	float angle = degrees(atan(uv.y, uv.x)); // angle from center	
	return step(mod(angle + t + thickness * log(d), 30.0), thickness);
}

vec2 rotate(vec2 uv, float r) {
	mat2 mt = mat2(cos(r), -sin(r), sin(r), cos(r));	
	return uv * mt;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float t = iTime;
	vec2 mid = vec2(0.5,0.5);	
	float d = distance(uv, mid);
	
	float size = 64.0 + sin(t * 0.5) * 32.0;

	float r = t * 0.5;
	float c1 = turbulence(rotate(uv, r), size, iChannel0);
	float c2 = turbulence(rotate(uv, -r), size, iChannel1);

	float c = (c1 + c2) / 2.0;
	float s = getSpiral(uv, 50.0 - sin(t * 0.75) * 100.0);
	fragColor = vec4(c * 0.6,c * s,0.2,1.0);
}