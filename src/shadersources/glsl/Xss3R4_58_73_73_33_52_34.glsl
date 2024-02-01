#define ONE 0.00390625
#define ONEHALF 0.001953125


#define rgb(r,g,b) vec4(float(r) / 255.0, float(g) / 255.0, float(b) / 255.0, 1.0)

vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

// Perlin simplex noise
float snoise(vec2 v)
  {
  const vec4 C = vec4(0.211324865405187, 0.366025403784439,
					 -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
//  i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
//  i1.y = 1.0 - i1.x;
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod(i, 289.0);
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
	+ i.x + vec3(0.0, i1.x, 1.0 ));
  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
    dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}


float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 innerColor = rgb(244, 207, 4);
vec4 middleColor = rgb(227, 210, 225);
vec4 outerColor = rgb(203, 78, 187);


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = (fragCoord.xy / iResolution.xy);
	
	uv = (uv + (snoise(uv * vec2(4.0, 14.0)) * 0.06) - vec2(.02, .02));

	float split = .6;
	
	vec4 color;
	if(uv.x < split) {
		color = (innerColor * ((split - uv.x) * (4.0*split))) + (middleColor * (uv.x * 2.0));
	} else {
		color = (middleColor * ((split * 2.0) - uv.x) * 2.0) + (outerColor * ((uv.x - split) * 2.0));
	}
	
	float fromCenter = abs(uv.y - .5) * 1.75;
	color = (color * (1.0 - sin(fromCenter))) + (outerColor * sin(fromCenter + .5));
	

	fragColor = color;
	//float c = snoise(uv * vec2(12.0, 14.0));
	//fragColor = vec4(c, c, c, 1.0);
}