#define WEBCAM_RESOLUTION 512.0

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	// Sobel operator
	float offset = 1.0 / WEBCAM_RESOLUTION;
	vec3 o = vec3(-offset, 0.0, offset);
	vec4 gx = vec4(0.0);
	vec4 gy = vec4(0.0);
	vec4 t;
	gx += texture(iChannel0, uv + o.xz);
	gy += gx;
	gx += 2.0*texture(iChannel0, uv + o.xy);
	t = texture(iChannel0, uv + o.xx);
	gx += t;
	gy -= t;
	gy += 2.0*texture(iChannel0, uv + o.yz);
	gy -= 2.0*texture(iChannel0, uv + o.yx);
	t = texture(iChannel0, uv + o.zz);
	gx -= t;
	gy += t;
	gx -= 2.0*texture(iChannel0, uv + o.zy);
	t = texture(iChannel0, uv + o.zx);
	gx -= t;
	gy -= t;
	vec4 grad = sqrt(gx*gx + gy*gy);
	
	fragColor = vec4(grad);
}