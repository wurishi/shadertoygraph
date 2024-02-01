#ifdef GL_ES
precision mediump float;
#endif

//dashxdr
// showing the points while performing the mandelbrot function
// http://glsl.heroku.com/e#7185

//uniform float iTime;
//uniform vec3 iResolution;
//uniform vec2 iMouse;
//uniform sampler2D bb;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

	float sum = 0.0;
	float size = .0020;
	vec2 tpos = fragCoord.xy / iResolution.xy - .5;
	float px,py;
	float scale = 2.0;
	float basex = -0.5;
	float basey = 0.0;
	float x = basex + (iMouse.x-.5)*scale;
	float y = basey + (iMouse.y-.5)*scale;
	float t;
	if(true) // change to false to control with mouse
	{
		t = iTime;
		float t1 = t;
		float scale1 = .3;
		float t2 = t *.61223;
		float scale2 = .5;
		x = basex + scale1*cos(t1) + scale2*cos(t2);
		y = basey + scale1*sin(t1) + scale2*sin(t2);
	}

	vec2 position = 2.0 * tpos + vec2(basex, basey);

#define NUM 30
	float u, v;
	u = v = .317;

	for(int j=0;j<4;++j)
	{
		px = py = 0.0;
		float x0, y0;
		x0 = x + u;
		y0 = y + v;
		for (int i=0; i < NUM; ++i) {
			t = (px*px-py*py)+x0;
			py = (2.0*px*py) + y0;
			px = t;
			float dist = length(vec2(px, py) - position);
			if(dist > .0001)
				sum += size/dist;
			else break;
		}
		t = u;
		u = -v;
		v = t;
	}

	float val = sum;

	vec3 color;
	color = vec3(val, val*0.66666, 0.0);
	tpos *= 1.2;
#define INDENT .001
	vec3 tcolor;
	if(tpos.x>-.5 + INDENT && tpos.y>-.5 + INDENT &&
		tpos.x < .5-INDENT && tpos.y < .5-INDENT)
		tcolor = .9*texture(iChannel0, tpos+.5).rgb;
	else tcolor = vec3(0.0);
	fragColor = vec4(max(color,tcolor), 1.0);
}
