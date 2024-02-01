void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	#define M_PI 3.1415926535897932384626433832795
	#define thick 0.002
	#define twister_thick 0.20
	
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 white = vec4(1.0,1.0,1.0,1.0);
	
	float twist = (M_PI / 360.0 * (iTime * 150.0 + 
				(uv.y * 240.0) * sin((((iTime * 150.0 / 2.0) + 
				(uv.y * 240.0)) * 3.0 / 4.0) * M_PI / 180.0) ));
	
	float x0 = 0.5 + (cos(twist) * twister_thick);
	float x1 = 0.5 + (cos(0.5 * M_PI + twist) * twister_thick);
	float x2 = 0.5 + (cos(1.0 * M_PI + twist) * twister_thick);
	float x3 = 0.5 + (cos(1.5 * M_PI + twist) * twister_thick);
	
	fragColor = vec4(uv,0.5+0.5*sin(iTime+270.0),1.0) * vec4(0.1,0.3,0.5,1.0);

	if (x0 < x1) {
		if ((abs(uv.x - x0) < thick) || (abs(uv.x - x1) < thick)) {
			fragColor = white;
		} else {
			if ((uv.x > x0) && (uv.x < x1)) {
				fragColor = vec4(uv,0.5+0.2*sin(iTime),1.0);
			}
		}
	}
	if (x1 < x2) {
		if ((abs(uv.x - x1) < thick) || (abs(uv.x - x2) < thick)) {
			fragColor = white;
		} else {
			if ((uv.x > x1) && (uv.x < x2)) {
				fragColor = vec4(uv,0.2+0.2*sin(iTime+45.0),1.0);
			}
		}
	}
	if (x2 < x3) {
		if ((abs(uv.x - x2) < thick) || (abs(uv.x - x3) < thick)) {
			fragColor = white;
		} else {
			if ((uv.x > x2) && (uv.x < x3)) {
				fragColor = vec4(uv,0.5+0.2*sin(iTime+90.0),1.0);
			}
		}
	}
	if (x3 < x0) {
		if ((abs(uv.x - x3) < thick) || (abs(uv.x - x0) < thick)) {
			fragColor = white;
		} else {
			if ((uv.x > x3) && (uv.x < x0)) {
				fragColor = vec4(uv,0.2+0.5*sin(iTime+135.0),1.0);
			}
		}
	}
}