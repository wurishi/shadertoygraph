
vec2 rotate(vec2 v, float r)
{
	float x = v.x*cos(r) - v.y*sin(r);
	float y = v.x*sin(r) + v.y*cos(r);
	return vec2(x,y);
}

vec3 ellipse(vec2 uv, vec2 p, vec2 l, float r, vec3 incol, vec3 col)
{
	vec2 puv = uv - p;
	
	puv = rotate(puv,r);
	
	puv.x /= l.x/l.y;
	
	if(length(puv) <= l.y)
	{
		float f = (l.y - length(puv))*iResolution.y/2.5;
		return mix(incol, col , clamp(f, 0.0, 1.0));
	}
	return incol;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv = 2.*uv - 1.;
	float aspect = iResolution.x / iResolution.y;
	uv.x *= aspect;
	
	float vign = 1./exp(length(uv)*0.4);
	//vec3 col = vec3(1.0, 1.0, 1.0) * vign;
	vec3 col = vec3(0.2, 0.12, 0.2) * vign;
	
	float xOff = texture(iChannel0, vec2(0.1, 0.01)).x/2.;
	float yOff = texture(iChannel0, vec2(0.2, 0.01)).x/2.;
	float rOff = texture(iChannel0, vec2(0.7, 0.01)).x*2.;
	
	vec2 eSize = vec2(yOff/50.0, 2.0);
	
	for (float i = 0.; i < 16.; i +=1.)
	{
		col = ellipse(uv, vec2( (i/16. * 2. - 1.) * aspect, 0), eSize, 0., col, vec3(0.2, 0.2, 0.2));
	}
	
	eSize = vec2(rOff/2.0, .01);
	
	for (float i = 0.; i < 16.; i+=1.)
	{
		vec2 spos = rotate(vec2(rOff/2.,0.), (6.2832*i)/16.);
		col = ellipse(uv, rotate(spos,iTime), eSize, -iTime - (i*6.2832)/16., col, vec3(0.3, 0.3, 0.3));
	}
	
	col = ellipse(uv, vec2(0.,0.), vec2(xOff, yOff),
				  iTime, col, vec3(0.1, 0.3, 0.9));
	eSize = vec2(xOff/4., yOff/4.);
	for(float i = 0.; i < 16.; i+=1.)
	{
		vec2 spos = rotate(vec2(rOff,0.), (6.2832*i)/16.);
		col = ellipse(uv, rotate(spos,iTime), eSize, -iTime, col, vec3(0.9, 0.3, 0.1));
	}
	
	
	fragColor = vec4(col,1.0);
}