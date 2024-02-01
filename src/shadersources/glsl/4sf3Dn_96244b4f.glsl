
float hash( float n )
{
    return fract(sin(n)*43758.5453);
}

float noise( in vec3 abc )
{
    vec3 p = floor(abc);
    vec3 f = fract(abc);

    f = f*f*(3.0-2.0*f);

    float n = p.x + p.y*57.0 + 113.0*p.z;

    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}

float calc(vec2 uv)
{
	uv = uv*iTime;
	float a = (uv.y * iResolution.x/2.0 * cos(iTime))/(uv.x * iResolution.y/2.0 * sin(iTime));
	return a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 newUv;
 		newUv.x = uv.x;
  		newUv.y = uv.y;
		newUv += vec2( iTime, 0.0 );
	
	vec3 texSample 	= texture( iChannel0, newUv ).rgb;
	vec3 abc = vec3(uv, 30.0);
	abc = abc * texture( iChannel0, newUv ).rgb * texSample;
	fragColor = vec4(uv,0.5+0.5*sin(iTime),0.5) / noise(vec3(uv.xy * 200.0,calc(uv)));
	fragColor.rgb = fragColor.rgb + abc * .05;
}