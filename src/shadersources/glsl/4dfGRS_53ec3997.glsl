
const int stepCount = 42;
float st[42];

float beat()
{
	float pos = mod(iTime * 32., 41.);
    int i = int(pos);
	pos = pos - float(i);
	
	float v1 = st[i];
	float v2 = st[i+1];
	return 1. + (mix(v1, v2, pos) / 100.) * .2;
}


vec3 heart( float x, float y )
{
    float s = mod( iTime, 2.0 )/2.0;
    s = 0.9 + 0.1*(1.0-exp(-5.0*s)*sin(50.0*s));
	s = beat();
    x *= s;
    y *= s;
    float a = atan(x,y)/3.141593;
    float r = sqrt(x*x+y*y);

    float h = abs(a);
    float d = (13.0*h - 22.0*h*h + 10.0*h*h*h)/(6.0-5.0*h);

    float f = smoothstep(d-0.02,d,r);
    float g = pow(1.0-clamp(r/d,0.0,1.0),0.25);
    return mix(vec3(0.5+0.5*g,0.2,0.1),vec3(1.0),f);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	int i = 0;
	// This is just silly. Send this as an uniform array or something:
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 5.;
	st[i++] = 30.;
	st[i++] = 100.;
	st[i++] = 30.;
	st[i++] = -30.;
	st[i++] = -100.;
	st[i++] = -30.;
	st[i++] = -2.;
	st[i++] = 0.;
	st[i++] = 9.;
	st[i++] = 60.;
	st[i++] = 0.;
	st[i++] = -60.;
	st[i++] = -10.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	st[i++] = 0.;
	// Bloody webgl glsl
	
    vec2 p = (-1.0+2.0*fragCoord.xy/iResolution.xy);

    vec3 col = heart(2.0*p.x, 2.0*p.y );
    fragColor = vec4(col,.5);

}
