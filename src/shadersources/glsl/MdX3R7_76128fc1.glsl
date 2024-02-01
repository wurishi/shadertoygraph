precision highp float;

vec2 uv,C;
vec2 Z, dZ;
vec2 sqr_Z;
float sqr_norm_Z, sqr_norm_dZ;
int iter_count;
 
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	float time = iTime;
	float zoo = 1.3;// * (0.99 * (sin(time/10.0))/2.);
	uv = (-1.0 + 2.0*(fragCoord.xy / iResolution.xy))*zoo;
	Z = uv;
	int ic;
	dZ = vec2(0., 0.);
	C = vec2((iMouse.x/iResolution.x) + 0.5*sin(time/100.0),
			 (iMouse.y/iResolution.y) - 0.5*sin(time/100.0));
	for(int iter_count = 0; iter_count < 32; ++iter_count) {
	  sqr_Z = vec2(Z.x * Z.x, Z.y * Z.y);
	  if (dot(sqr_Z,sqr_Z) < 8.)
	  {
		  ic+=1;
		  dZ = vec2(2.0 * (Z.x * dZ.y - Z.x * dZ.y) + 1.0,
					2.0 * (Z.y * dZ.x + Z.y * dZ.x));
		  Z = vec2(sqr_Z.x - sqr_Z.y,
				   2.0 * Z.x * Z.y) + C;
	  }
    }
	sqr_norm_Z = Z.x* Z.x + Z.y*Z.y;
	sqr_norm_dZ = dZ.x * dZ.x + dZ.y * dZ.y;
	vec4 color0 = vec4(0., 0., 0., 1.0);
	vec4 color1 = vec4(0.5+0.5*cos(float(ic/32) * (1./(uv.x*uv.y))),
					   0.5+0.5*cos(sqr_norm_Z),
					   0.5+0.5*cos(sqr_norm_dZ), 1.0);
 
    float co = 0.5 + 0.5*sin((sqr_norm_dZ/sqr_norm_Z));
    fragColor = mix(color0,color1,co);

}